-- USeP e-Registrar Database Schema

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+08:00";

-- --------------------------------------------------------
-- Table Structure for `users`
-- --------------------------------------------------------
CREATE TABLE `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `university_id` VARCHAR(20) NOT NULL UNIQUE, -- e.g., 2021-04182 or REG-ADMIN-04
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password_hash` VARCHAR(255) NOT NULL,
  `role` ENUM('student', 'admin', 'registrar', 'cashier') NOT NULL DEFAULT 'student',
  `college` VARCHAR(100) DEFAULT NULL,
  `program` VARCHAR(100) DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table Structure for `document_types`
-- --------------------------------------------------------
CREATE TABLE `document_types` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `category` ENUM('Academic Records', 'Certifications', 'Graduation & Transfer') NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `base_fee` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `is_active` BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table Structure for `requests` (The core transaction table)
-- --------------------------------------------------------
CREATE TABLE `requests` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tracking_code` VARCHAR(20) NOT NULL UNIQUE, -- e.g. DOC-2026-0001
  `student_id` INT NOT NULL,
  `fulfillment_method` ENUM('pickup', 'delivery') NOT NULL,
  `payment_method` ENUM('cash', 'cashier', 'online') NOT NULL,
  `total_fee` DECIMAL(10,2) NOT NULL,
  `status` ENUM('Pending Review', 'Processing', 'Ready for Pickup', 'Completed', 'Declined') NOT NULL DEFAULT 'Pending Review',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`student_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table Structure for `request_items` (Items inside a single request)
-- --------------------------------------------------------
CREATE TABLE `request_items` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `request_id` INT NOT NULL,
  `document_id` INT NOT NULL,
  `copies` INT NOT NULL DEFAULT 1,
  FOREIGN KEY (`request_id`) REFERENCES `requests`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`document_id`) REFERENCES `document_types`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table Structure for `audit_logs`
-- --------------------------------------------------------
CREATE TABLE `audit_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `action` VARCHAR(255) NOT NULL,
  `entity_type` VARCHAR(50) NOT NULL, -- e.g., 'requests', 'users'
  `entity_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Dummy Data Insertion (To replace your hardcoded HTML)
-- --------------------------------------------------------

-- Default Admin (Password is 'admin123' - you will hash this in PHP via password_hash)
INSERT INTO `users` (`university_id`, `first_name`, `last_name`, `email`, `password_hash`, `role`) VALUES 
('REG-ADMIN-04', 'Registrar', 'Admin', 'admin@usep.edu.ph', '$2y$10$6CQ8b6gJlVHJDgxdo33oUOtwT1YKoMZ8p79SNc4vu4HHTvvZkLYYa', 'admin');

-- Default Student (Password is 'student123')
INSERT INTO `users` (`university_id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `college`, `program`) VALUES 
('2021-04182', 'Joshua', 'Pearce', 'joshua@usep.edu.ph', '$2y$10$/Koyp37hqcYtDiqSELEXq.xV.fL8OMesKRbap1FjZJw4v3nYA0IAW', 'student', 'College of Computing', 'BS Computer Science');

-- Default Document Types
INSERT INTO `document_types` (`category`, `name`, `base_fee`) VALUES 
('Academic Records', 'Transcript of Records (TOR)', 150.00),
('Academic Records', 'Form 137 (Permanent Record)', 100.00),
('Certifications', 'Certificate of Enrollment', 50.00),
('Certifications', 'Certificate of Good Moral Character', 50.00),
('Certifications', 'Certificate of General Weighted Average', 50.00),
('Graduation & Transfer', 'Honorable Dismissal', 100.00),
-- --------------------------------------------------------
-- Table Structure for `record_corrections`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `record_corrections` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tracking_code` VARCHAR(30) NOT NULL UNIQUE,
  `student_id` INT NOT NULL,
  `category` VARCHAR(50) NOT NULL,
  `current_value` VARCHAR(255) NOT NULL,
  `proposed_value` VARCHAR(255) NOT NULL,
  `contact_number` VARCHAR(30) NOT NULL,
  `reason` TEXT NOT NULL,
  `supporting_documents` TEXT DEFAULT NULL,
  `status` ENUM('Pending Review', 'Under Review', 'Needs More Info', 'Approved', 'Rejected') NOT NULL DEFAULT 'Pending Review',
  `registrar_remarks` TEXT DEFAULT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`student_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Records Correction demo data
INSERT INTO `record_corrections` (`tracking_code`, `student_id`, `category`, `current_value`, `proposed_value`, `contact_number`, `reason`, `supporting_documents`, `status`, `registrar_remarks`) VALUES 
('CR-2026-000842', 2, 'name', 'JOSHUA PEARCE', 'JOSHUA MANUEL PEARCE', '+63 947 882 1094', 'My official Philippine Statistics Authority (PSA) Certificate of Live Birth indicates my complete middle name as MANUEL instead of single initial M.', '[{\"name\":\"PSA_Birth_Certificate_JoshuaPearce.pdf\",\"size\":2415919,\"type\":\"application/pdf\"}]', 'Under Review', 'Awaiting secondary ID copy from student for final validation.'),
('CR-2025-000109', 2, 'curriculum', 'BS Computer Science (Curriculum Year 2020)', 'BS Computer Science (Curriculum Year 2021)', '+63 947 882 1094', 'Curriculum tagging alignment per College of Computing Dean memorandum regarding 2021 curriculum catalog shift.', NULL, 'Approved', 'Curriculum tagging verified with College Dean. SIS ledger updated successfully.');

COMMIT;

