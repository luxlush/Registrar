<?php
require_once __DIR__ . '/../dist/api/db_connect.php';

$sql = "
SELECT COUNT(*) as total FROM (
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
) AS q
";

$res = $pdo->query($sql)->fetch();
echo "Total combined count: " . $res['total'] . "\n";
