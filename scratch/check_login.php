<?php
try {
    $p = new PDO('mysql:host=127.0.0.1;port=3306;dbname=usep_registrar', 'root', '');
    foreach ($p->query('SELECT id,university_id,email,role,password_hash FROM users') as $r) {
        echo json_encode($r), PHP_EOL;
        foreach (['admin123', 'student123', 'password'] as $pw) {
            echo "  $pw => ", var_export(password_verify($pw, $r['password_hash']), true), PHP_EOL;
        }
    }
} catch (Exception $e) {
    echo 'ERR: ', $e->getMessage(), PHP_EOL;
}
