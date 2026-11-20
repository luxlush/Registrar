<?php
// Resets the demo account passwords in the local usep_registrar database.
//   admin@usep.edu.ph  -> admin123
//   joshua@usep.edu.ph -> student123
$p = new PDO('mysql:host=127.0.0.1;port=3306;dbname=usep_registrar', 'root', '', [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$st = $p->prepare('UPDATE users SET password_hash = ? WHERE email = ?');
$st->execute([password_hash('admin123', PASSWORD_DEFAULT), 'admin@usep.edu.ph']);
echo "admin rows: ", $st->rowCount(), PHP_EOL;
$st->execute([password_hash('student123', PASSWORD_DEFAULT), 'joshua@usep.edu.ph']);
echo "student rows: ", $st->rowCount(), PHP_EOL;
