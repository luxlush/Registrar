<?php
require_once __DIR__ . '/../dist/api/db_connect.php';

function desc($pdo, $table) {
    echo "=== $table ===\n";
    $stmt = $pdo->query("DESCRIBE $table");
    foreach ($stmt->fetchAll() as $col) {
        echo "  " . $col['Field'] . " (" . $col['Type'] . ")\n";
    }
}

desc($pdo, 'requests');
desc($pdo, 'request_items');
desc($pdo, 'document_types');
desc($pdo, 'correction_requests');
desc($pdo, 'correction_categories');

echo "=== REQUEST COUNT ===\n";
echo "requests: " . $pdo->query("SELECT COUNT(*) FROM requests")->fetchColumn() . "\n";
echo "correction_requests: " . $pdo->query("SELECT COUNT(*) FROM correction_requests")->fetchColumn() . "\n";
