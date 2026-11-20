-- ============================================================================
-- Migration: 001_create_corrections_tables.sql
-- USeP e-Registrar: Records Correction MySQL Schema
-- Safe to run multiple times in phpMyAdmin SQL tab or via migration runner.
-- ============================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Safely add missing official student record columns to `users` if not already present
-- MariaDB / MySQL 10.3+ supports ADD COLUMN IF NOT EXISTS
ALTER TABLE `users`
  ADD COLUMN IF NOT EXISTS `middle_name` VARCHAR(50) NULL AFTER `first_name`,
  ADD COLUMN IF NOT EXISTS `birthdate` DATE NULL AFTER `program`,
  ADD COLUMN IF NOT EXISTS `gender` VARCHAR(20) NULL AFTER `birthdate`,
  ADD COLUMN IF NOT EXISTS `place_of_birth` VARCHAR(150) NULL AFTER `gender`,
  ADD COLUMN IF NOT EXISTS `civil_status` VARCHAR(50) NULL DEFAULT 'Single' AFTER `place_of_birth`,
  ADD COLUMN IF NOT EXISTS `contact_number` VARCHAR(30) NULL AFTER `civil_status`;

-- Populate baseline values for demo student Joshua Pearce (2021-04182)
UPDATE `users`
SET 
  `middle_name` = COALESCE(`middle_name`, 'Manuel'),
  `birthdate` = COALESCE(`birthdate`, '2003-05-14'),
  `gender` = COALESCE(`gender`, 'Male'),
  `place_of_birth` = COALESCE(`place_of_birth`, 'Davao City'),
  `civil_status` = COALESCE(`civil_status`, 'Single'),
  `contact_number` = COALESCE(`contact_number`, '+63 947 882 1094')
WHERE `university_id` = '2021-04182';

-- 2. Create `correction_categories` table
CREATE TABLE IF NOT EXISTS `correction_categories` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `code` VARCHAR(50) NOT NULL UNIQUE,
  `label` VARCHAR(100) NOT NULL,
  `description` TEXT NOT NULL,
  `icon` VARCHAR(50) NOT NULL,
  `requirements` LONGTEXT NOT NULL, -- JSON array of requirement objects
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Create `correction_requests` table
CREATE TABLE IF NOT EXISTS `correction_requests` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `tracking_code` VARCHAR(30) NOT NULL UNIQUE,
  `student_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  `current_value` VARCHAR(255) NOT NULL,
  `proposed_value` VARCHAR(255) NOT NULL,
  `contact_number` VARCHAR(30) NOT NULL,
  `reason` TEXT NOT NULL,
  `status` ENUM('Pending Review','Under Review','Needs More Info','Approved','Declined','Completed') NOT NULL DEFAULT 'Pending Review',
  `registrar_remarks` TEXT NULL,
  `reviewed_by` INT NULL,
  `reviewed_at` DATETIME NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `idx_student_id` (`student_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_created_at` (`created_at`),
  CONSTRAINT `fk_cr_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_cr_category` FOREIGN KEY (`category_id`) REFERENCES `correction_categories` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_cr_reviewer` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Create `correction_documents` table
CREATE TABLE IF NOT EXISTS `correction_documents` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `request_id` INT NOT NULL,
  `original_name` VARCHAR(255) NOT NULL,
  `stored_name` VARCHAR(255) NOT NULL,
  `mime_type` VARCHAR(100) NOT NULL,
  `size_bytes` BIGINT NOT NULL,
  `uploaded_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_doc_request` (`request_id`),
  CONSTRAINT `fk_cd_request` FOREIGN KEY (`request_id`) REFERENCES `correction_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Create `correction_status_history` table
CREATE TABLE IF NOT EXISTS `correction_status_history` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `request_id` INT NOT NULL,
  `from_status` VARCHAR(50) NULL,
  `to_status` VARCHAR(50) NOT NULL,
  `remarks` TEXT NULL,
  `changed_by` INT NOT NULL,
  `changed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_history_request` (`request_id`),
  CONSTRAINT `fk_csh_request` FOREIGN KEY (`request_id`) REFERENCES `correction_requests` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_csh_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Seed active categories with detailed requirement metadata
INSERT INTO `correction_categories` (`id`, `code`, `label`, `description`, `icon`, `requirements`, `is_active`) VALUES
(1, 'name', 'Name Spelling / Legal Correction', 'Surname, first name, middle name, or suffix discrepancy alignment with official civil registrar.', 'badge', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated PSA/NSO Certificate of Live Birth showing registered registry number and full name.\"},{\"icon\":\"badge\",\"title\":\"Two Government Photo IDs\",\"desc\":\"Two valid government photo IDs (e.g. Passport, Driver’s License, UMID, PhilID).\"},{\"icon\":\"description\",\"title\":\"Joint Affidavit (if applicable)\",\"desc\":\"Joint Affidavit of Two Disinterested Persons if discrepancy involves surname transposition.\"}]', 1),
(2, 'birthdate', 'Birthdate Correction', 'Discrepancy in date, month, or birth year recorded in the SIS student ledger.', 'calendar_month', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated Philippine Statistics Authority Certificate of Live Birth.\"},{\"icon\":\"school\",\"title\":\"Form 137 / SF10\",\"desc\":\"Certified True Copy of High School Permanent Record (Form 137-A) bearing matching birth date.\"},{\"icon\":\"badge\",\"title\":\"Government Photo ID\",\"desc\":\"Valid government photo ID verifying official birthdate.\"}]', 1),
(3, 'gender', 'Sex / Gender Marker', 'Correction of official sex or gender marker on school records.', 'transgender', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated PSA Birth Certificate indicating correct biological sex marker.\"},{\"icon\":\"gavel\",\"title\":\"Annotated Civil Registry\",\"desc\":\"Annotated PSA record if sex marker was legally corrected pursuant to R.A. 9048 or court decree.\"},{\"icon\":\"badge\",\"title\":\"Valid Government ID\",\"desc\":\"Primary government ID matching updated record.\"}]', 1),
(4, 'place_of_birth', 'Place of Birth', 'Discrepancy in city, municipality, or province of birth.', 'location_city', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated PSA Birth Certificate showing exact city/municipality of birth.\"},{\"icon\":\"badge\",\"title\":\"Valid Government ID\",\"desc\":\"Valid government ID reflecting registered place of birth.\"}]', 1),
(5, 'civil_status', 'Civil Status Update', 'Marriage status change, adoption of spouse surname, or legal decree updates.', 'family_restroom', '[{\"icon\":\"favorite\",\"title\":\"PSA Marriage Certificate\",\"desc\":\"Authenticated PSA Marriage Certificate for married female students adopting husband’s surname.\"},{\"icon\":\"gavel\",\"title\":\"Court Legal Decree\",\"desc\":\"Official Court Decree or Annotated PSA certificate (for legal annulment or legal name adoption).\"},{\"icon\":\"badge\",\"title\":\"Updated Government ID\",\"desc\":\"Valid government ID reflecting the newly adopted civil status or legal name.\"}]', 1),
(6, 'curriculum', 'Program, Curriculum, or Subject Code Update', 'Catalog year realignment, prerequisite tagging, or course credit fix.', 'auto_stories', '[{\"icon\":\"account_balance\",\"title\":\"Dean / Chair Endorsement\",\"desc\":\"Explicit formal endorsement memorandum from College Dean or Academic Department Chair.\"},{\"icon\":\"fact_check\",\"title\":\"Approved Curriculum Checklist\",\"desc\":\"Official signed curriculum prospectus showing catalog requirement shift.\"},{\"icon\":\"grade\",\"title\":\"Grade Verification Sheet\",\"desc\":\"Instructor grade validation sheet if subject prerequisite tagging is involved.\"}]', 1),
(7, 'other', 'Other Ledger Discrepancy', 'Any other formal academic or demographic record rectifications.', 'help_outline', '[{\"icon\":\"description\",\"title\":\"Official Letter Petition\",\"desc\":\"Formal letter addressed to the University Registrar stating discrepancy and desired alignment.\"},{\"icon\":\"verified\",\"title\":\"Supporting Credentials\",\"desc\":\"Official university or government certifications proving accurate ledger data.\"}]', 1)
ON DUPLICATE KEY UPDATE 
  `label` = VALUES(`label`),
  `description` = VALUES(`description`),
  `icon` = VALUES(`icon`),
  `requirements` = VALUES(`requirements`),
  `is_active` = VALUES(`is_active`);

-- 7. Seed initial demo correction request for Joshua Pearce (COR-260827)
INSERT INTO `correction_requests` 
  (`id`, `tracking_code`, `student_id`, `category_id`, `current_value`, `proposed_value`, `contact_number`, `reason`, `status`, `registrar_remarks`, `reviewed_by`, `reviewed_at`, `created_at`)
VALUES 
  (1, 'COR-260827', 2, 2, 'May 14, 2003', 'May 18, 2003', '+63 947 882 1094', 'Official PSA Certificate of Live Birth registered in Davao City indicates birth date as May 18, 2003 instead of May 14.', 'Under Review', 'PSA authenticated copy received. Awaiting secondary Form 137 validation.', 1, NOW(), DATE_SUB(NOW(), INTERVAL 4 DAY))
ON DUPLICATE KEY UPDATE `status` = VALUES(`status`);

-- 8. Seed initial document & status history for COR-260827
INSERT INTO `correction_documents`
  (`id`, `request_id`, `original_name`, `stored_name`, `mime_type`, `size_bytes`, `uploaded_at`)
VALUES
  (1, 1, 'PSA_Birth_Certificate_JoshuaPearce.pdf', 'doc_demo_psa_birth.pdf', 'application/pdf', 2415919, DATE_SUB(NOW(), INTERVAL 4 DAY))
ON DUPLICATE KEY UPDATE `original_name` = VALUES(`original_name`);

INSERT INTO `correction_status_history`
  (`id`, `request_id`, `from_status`, `to_status`, `remarks`, `changed_by`, `changed_at`)
VALUES
  (1, 1, NULL, 'Pending Review', 'Correction petition filed by student via online portal.', 2, DATE_SUB(NOW(), INTERVAL 4 DAY)),
  (2, 1, 'Pending Review', 'Under Review', 'Assigned to Registrar Evaluator Window 2 for civil registry verification.', 1, DATE_SUB(NOW(), INTERVAL 2 DAY))
ON DUPLICATE KEY UPDATE `to_status` = VALUES(`to_status`);

SET FOREIGN_KEY_CHECKS = 1;
