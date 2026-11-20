<?php
require_once __DIR__ . '/../dist/api/db_connect.php';

$stmt = $pdo->query("SELECT request_id, COUNT(*) as cnt FROM request_items GROUP BY request_id HAVING cnt > 1");
$multi = $stmt->fetchAll();
echo "Multi-item requests count: " . count($multi) . "\n";
print_r($multi);
