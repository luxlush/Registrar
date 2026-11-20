<?php
require_once __DIR__ . '/../dist/api/db_connect.php';

function testQueueQuery($pdo, $params) {
    $search = trim($params['search'] ?? '');
    $docType = trim($params['doc_type'] ?? 'all');
    $deliveryMode = trim($params['delivery_mode'] ?? 'all');
    $statusFilter = trim($params['status'] ?? 'all');
    $page = max(1, (int)($params['page'] ?? 1));
    $perPage = min(50, max(1, (int)($params['per_page'] ?? 10)));

    $whereClauses = ["1=1"];
    $bindParams = [];

    // Search
    if ($search !== '') {
        $whereClauses[] = "(
            q.tracking_code LIKE :search_track 
            OR q.university_id LIKE :search_univ 
            OR q.program LIKE :search_prog 
            OR q.first_name LIKE :search_first 
            OR q.last_name LIKE :search_last 
            OR CONCAT(q.first_name, ' ', q.last_name) LIKE :search_full 
            OR q.document_name LIKE :search_doc
        )";
        $term = '%' . $search . '%';
        $bindParams[':search_track'] = $term;
        $bindParams[':search_univ'] = $term;
        $bindParams[':search_prog'] = $term;
        $bindParams[':search_first'] = $term;
        $bindParams[':search_last'] = $term;
        $bindParams[':search_full'] = $term;
        $bindParams[':search_doc'] = $term;
    }

    // Status filter
    if ($statusFilter !== 'all' && $statusFilter !== '') {
        if ($statusFilter === 'processing') {
            $whereClauses[] = "q.status IN ('Processing', 'Under Review')";
        } elseif ($statusFilter === 'ready') {
            $whereClauses[] = "q.status = 'Ready for Pickup'";
        } elseif ($statusFilter === 'review') {
            $whereClauses[] = "q.status IN ('Pending Review', 'Needs More Info')";
        } elseif ($statusFilter === 'completed') {
            $whereClauses[] = "q.status IN ('Completed', 'Approved')";
        } elseif ($statusFilter === 'declined') {
            $whereClauses[] = "q.status IN ('Declined', 'Rejected')";
        } else {
            $whereClauses[] = "q.status = :status";
            $bindParams[':status'] = $statusFilter;
        }
    }

    // Document Type filter
    if ($docType !== 'all' && $docType !== '') {
        if ($docType === 'tor') {
            $whereClauses[] = "q.document_name LIKE '%Transcript%'";
        } elseif ($docType === 'grad-cert') {
            $whereClauses[] = "q.document_name LIKE '%Graduation%'";
        } elseif ($docType === 'correction') {
            $whereClauses[] = "q.item_kind = 'correction'";
        } elseif ($docType === 'diploma') {
            $whereClauses[] = "q.document_name LIKE '%Diploma%'";
        } elseif ($docType === 'dismissal') {
            $whereClauses[] = "q.document_name LIKE '%Dismissal%'";
        }
    }

    // Delivery Mode filter
    if ($deliveryMode !== 'all' && $deliveryMode !== '') {
        if ($deliveryMode === 'counter') {
            $whereClauses[] = "q.fulfillment_method = 'pickup'";
        } elseif ($deliveryMode === 'courier') {
            $whereClauses[] = "q.fulfillment_method = 'delivery'";
        } elseif ($deliveryMode === 'digital') {
            $whereClauses[] = "q.fulfillment_method = 'digital'";
        }
    }

    $whereSql = implode(' AND ', $whereClauses);

    $baseUnionSql = "
        SELECT 
            r.id, 
            r.tracking_code, 
            r.status, 
            r.created_at,
            r.fulfillment_method,
            u.first_name, 
            u.last_name, 
            u.university_id, 
            u.program,
            GROUP_CONCAT(DISTINCT dt.name SEPARATOR ', ') as document_name,
            GROUP_CONCAT(DISTINCT dt.category SEPARATOR ', ') as document_category,
            'document' as item_kind
        FROM requests r
        JOIN users u ON r.student_id = u.id
        LEFT JOIN request_items ri ON r.id = ri.request_id
        LEFT JOIN document_types dt ON ri.document_id = dt.id
        GROUP BY r.id

        UNION ALL

        SELECT
            cr.id,
            cr.tracking_code,
            cr.status,
            cr.created_at,
            'digital' as fulfillment_method,
            u.first_name,
            u.last_name,
            u.university_id,
            u.program,
            CONCAT(cc.label, ': ', cr.proposed_value) as document_name,
            'Records Correction' as document_category,
            'correction' as item_kind
        FROM correction_requests cr
        JOIN correction_categories cc ON cr.category_id = cc.id
        JOIN users u ON cr.student_id = u.id
    ";

    // 1. Count query
    $countSql = "SELECT COUNT(*) FROM ($baseUnionSql) AS q WHERE $whereSql";
    $countStmt = $pdo->prepare($countSql);
    foreach ($bindParams as $key => $val) {
        $countStmt->bindValue($key, $val, PDO::PARAM_STR);
    }
    $countStmt->execute();
    $total = (int)$countStmt->fetchColumn();

    $totalPages = $total > 0 ? (int)ceil($total / $perPage) : 1;
    if ($page > $totalPages) {
        $page = $totalPages;
    }
    $offset = ($page - 1) * $perPage;

    // 2. Data query
    $dataSql = "
        SELECT * FROM ($baseUnionSql) AS q 
        WHERE $whereSql 
        ORDER BY created_at DESC, id DESC 
        LIMIT :limit OFFSET :offset
    ";
    $dataStmt = $pdo->prepare($dataSql);
    foreach ($bindParams as $key => $val) {
        $dataStmt->bindValue($key, $val, PDO::PARAM_STR);
    }
    $dataStmt->bindValue(':limit', $perPage, PDO::PARAM_INT);
    $dataStmt->bindValue(':offset', $offset, PDO::PARAM_INT);
    $dataStmt->execute();
    $items = $dataStmt->fetchAll();

    return [
        'total' => $total,
        'page' => $page,
        'per_page' => $perPage,
        'total_pages' => $totalPages,
        'count' => count($items)
    ];
}

echo "Page 1: ";
print_r(testQueueQuery($pdo, ['page' => 1, 'per_page' => 10]));

echo "Page 5: ";
print_r(testQueueQuery($pdo, ['page' => 5, 'per_page' => 10]));

echo "Page 10 (clamped): ";
print_r(testQueueQuery($pdo, ['page' => 10, 'per_page' => 10]));

echo "Filter search 'joshua': ";
print_r(testQueueQuery($pdo, ['search' => 'joshua', 'per_page' => 10]));
