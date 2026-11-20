-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2026 at 09:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `usep_registrar`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_terms`
--

CREATE TABLE `academic_terms` (
  `id` int(11) NOT NULL,
  `school_year` varchar(30) NOT NULL,
  `semester` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `adddrop_open` datetime NOT NULL,
  `adddrop_cutoff` datetime NOT NULL,
  `policy_ref` varchar(100) NOT NULL DEFAULT 'IRR-2024-C',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `academic_terms`
--

INSERT INTO `academic_terms` (`id`, `school_year`, `semester`, `start_date`, `end_date`, `adddrop_open`, `adddrop_cutoff`, `policy_ref`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'S.Y. 2026-2027', '1st Semester', '2026-08-10', '2026-12-18', '2026-10-01 00:00:00', '2026-10-23 23:59:59', 'IRR-2024-C', 1, '2026-10-19 14:13:56', '2026-10-19 14:13:56'),
(2, 'S.Y. 2025-2026', '1st Semester', '0000-00-00', '0000-00-00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'IRR-2024-C', 0, '2026-10-19 18:28:52', '2026-10-19 18:28:52'),
(3, 'S.Y. 2025-2026', '2nd Semester', '0000-00-00', '0000-00-00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'IRR-2024-C', 0, '2026-10-19 18:28:52', '2026-10-19 18:28:52'),
(4, 'S.Y. 2026-2027', '2nd Semester', '0000-00-00', '0000-00-00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'IRR-2024-C', 0, '2026-10-19 18:28:52', '2026-10-19 18:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `academic_transactions`
--

CREATE TABLE `academic_transactions` (
  `id` int(11) NOT NULL,
  `docket_no` varchar(50) NOT NULL,
  `module` enum('add_drop','shifting','graduation','loa') NOT NULL,
  `student_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending Evaluation',
  `academic_term` varchar(100) NOT NULL DEFAULT 'S.Y. 2026-2027 • 1st Semester',
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `remarks` text DEFAULT NULL,
  `evaluated_by` int(11) DEFAULT NULL,
  `evaluated_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `academic_transactions`
--

INSERT INTO `academic_transactions` (`id`, `docket_no`, `module`, `student_id`, `status`, `academic_term`, `details`, `remarks`, `evaluated_by`, `evaluated_at`, `created_at`, `updated_at`) VALUES
(1, 'ACA-26071', 'add_drop', 5, 'Completed', 'S.Y. 2026-2027 • 1st Semester', '{\"reference_code\":\"ACA-26071\",\"action_type\":\"Add\\/Drop Adjustment\",\"course_added\":\"IT 223 - Web Systems and Technologies\",\"course_dropped\":\"PE 3 - Physical Activities Towards Fitness\",\"schedule\":\"TTh 10:30-12:00 (CS-Lab 4)\",\"section\":\"BSIT 2-C\",\"units_change\":\"+3.0 Units\",\"total_load\":\"21.0 Units\",\"capacity\":\"38 \\/ 40 Enrolled\",\"dean_endorsement\":\"Endorsement_CIC_Waiver_Reyes_P.pdf\"}', 'Pending registrar authorization. Prerequisite validation auto-checked against Curricular Prospectus 2023 rev.', 1, NULL, '2026-10-19 12:28:03', '2026-10-19 15:19:05'),
(2, 'ACA-26072', 'add_drop', 2, 'Completed', 'S.Y. 2026-2027 • 1st Semester', '{\"reference_code\":\"ACA-26072\",\"action_type\":\"Unit Overload Request\",\"course_added\":\"CS 412 - Intelligent Systems\",\"schedule\":\"MWF 13:00-14:30 (Lab 2)\",\"section\":\"BSCS 4-A\",\"units_change\":\"+3.0 Units\",\"total_load\":\"24.0 Units (Authorized Overload)\"}', 'Approved by Registrar Evaluator. Graduating standing verified.', 1, NULL, '2026-10-19 12:28:03', '2026-10-19 15:24:02'),
(3, 'ACA-26068', 'shifting', 6, 'Pending Review', 'S.Y. 2026-2027 • 1st Semester', '{\"reference_code\":\"ACA-26068\",\"shifting_type\":\"Internal College Shift\",\"former_program\":\"BA Communication\",\"former_college\":\"College of Arts and Sciences\",\"target_program\":\"BS Psychology\",\"target_college\":\"College of Arts and Sciences\",\"reason\":\"Medical & Clinical Path Alignment\",\"credited_units\":32,\"standing\":\"Regular 2nd Year Standing\",\"gwa\":1.34,\"dean_endorsed\":true}', 'Endorsed by CAS Dean and Psychology Dept Head. Endorsement memo attached.', NULL, NULL, '2026-10-19 12:28:03', '2026-10-19 12:28:03'),
(4, 'ACA-26069', 'shifting', 2, 'Approved', 'S.Y. 2025-2026 • 2nd Semester', '{\"reference_code\":\"ACA-26069\",\"shifting_type\":\"Internal Shift\",\"former_program\":\"BS Information Technology\",\"former_college\":\"College of Information and Computing\",\"target_program\":\"BS Computer Science\",\"target_college\":\"College of Information and Computing\",\"reason\":\"Specialization in Systems Programming\",\"credited_units\":45,\"standing\":\"Regular 3rd Year\",\"gwa\":1.4,\"dean_endorsed\":true}', 'Curricular evaluation completed and units transferred to BSCS curriculum.', NULL, NULL, '2026-10-19 12:28:03', '2026-10-19 12:28:03'),
(5, 'ACA-26055', 'graduation', 7, 'Final Audit Cleared', 'S.Y. 2025-2026 • 2nd Semester', '{\"reference_code\":\"ACA-26055\",\"candidate_program\":\"BS Civil Engineering\",\"candidate_college\":\"College of Engineering (CoE)\",\"honors_shortlist\":\"Magna Cum Laude\",\"gwa\":1.48,\"total_units_completed\":178,\"deficiencies_count\":0,\"residency_years\":4,\"bor_status\":\"Endorsed for 46th Commencement Exercises\"}', 'All collegiate clearances, PSA birth certificate, Form 137, and thesis defense certificates confirmed on file.', NULL, NULL, '2026-10-19 12:28:03', '2026-10-19 12:28:03'),
(6, 'ACA-26056', 'graduation', 2, 'Pending Review', 'S.Y. 2026-2027 • 1st Semester', '{\"reference_code\":\"ACA-26056\",\"candidate_program\":\"BS Computer Science\",\"candidate_college\":\"College of Information and Computing (CIC)\",\"honors_shortlist\":\"Magna Cum Laude (Candidate)\",\"gwa\":1.42,\"total_units_completed\":128,\"deficiencies_count\":0,\"residency_years\":3.5,\"bor_status\":\"Pending Final Semester Clearance\"}', 'Preliminary graduation evaluation in progress. Enrolled in Capstone 2.', NULL, NULL, '2026-10-19 12:28:03', '2026-10-19 12:28:03'),
(7, 'ACA-26043', 'loa', 8, 'Completed', 'S.Y. 2026-2027 • 1st Semester', '{\"reference_code\":\"ACA-26043\",\"case_type\":\"Readmission after one semester LOA\",\"leave_period\":\"1st Sem 2025-2026\",\"reason\":\"Medical Rest & Clinical Recuperation\",\"clearances\":{\"University Health Services\":\"Fit to Enroll Certified\",\"Guidance & Counseling\":\"Interview Completed\",\"College Dean\":\"Endorsed\",\"Cashier\":\"No Outstanding Dues\"},\"program\":\"BS Entrepreneurship\",\"college\":\"College of Business Administration\",\"curriculum\":\"Curriculum 2021-V2\",\"mrr_years\":\"3.0 \\/ 6.0 Years (Compliant)\"}', 'Completed. Eligible for S.Y. 2026-2027 Re-enrollment. SIS account restored to Active status.', NULL, NULL, '2026-10-19 12:28:03', '2026-10-19 12:28:03'),
(8, 'ACA-26044', 'loa', 5, 'Pending Review', 'S.Y. 2026-2027 • 1st Semester', '{\"reference_code\":\"ACA-26044\",\"case_type\":\"Leave of Absence Filing\",\"leave_period\":\"2nd Sem 2026-2027\",\"reason\":\"Family Financial Support & Remote Employment\",\"program\":\"BS Information Technology\",\"college\":\"College of Information and Computing\",\"mrr_years\":\"2.5 \\/ 6.0 Years\"}', 'Under department review. Awaiting endorsement from CIC Dean.', NULL, NULL, '2026-10-19 12:28:03', '2026-10-19 12:28:03');

-- --------------------------------------------------------

--
-- Table structure for table `academic_transaction_history`
--

CREATE TABLE `academic_transaction_history` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adddrop_documents`
--

CREATE TABLE `adddrop_documents` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int(11) NOT NULL DEFAULT 0,
  `mime_type` varchar(100) NOT NULL DEFAULT 'application/pdf',
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adddrop_documents`
--

INSERT INTO `adddrop_documents` (`id`, `request_id`, `file_name`, `file_path`, `file_size`, `mime_type`, `uploaded_at`) VALUES
(4, 1, 'Endorsement_CIC_Waiver_Reyes_P.pdf', 'storage/adddrop_docs/Endorsement_CIC_Waiver_Reyes_P.pdf', 555008, 'application/pdf', '2026-10-16 00:35:00');

-- --------------------------------------------------------

--
-- Table structure for table `adddrop_endorsements`
--

CREATE TABLE `adddrop_endorsements` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `role` enum('Dept Chair','College Dean') NOT NULL,
  `name` varchar(150) NOT NULL,
  `status` enum('Endorsed','Authorized','Pending','Declined') NOT NULL DEFAULT 'Endorsed',
  `endorsed_at` datetime DEFAULT NULL,
  `letter_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adddrop_endorsements`
--

INSERT INTO `adddrop_endorsements` (`id`, `request_id`, `role`, `name`, `status`, `endorsed_at`, `letter_path`, `created_at`) VALUES
(7, 1, 'Dept Chair', 'Dr. Aaron T. Dizon', 'Endorsed', '2026-10-15 14:20:00', NULL, '2026-10-19 15:30:26'),
(8, 1, 'College Dean', 'Dean Marissa V. Del Rosario', 'Authorized', '2026-10-16 08:30:00', 'storage/adddrop_docs/Endorsement_CIC_Waiver_Reyes_P.pdf', '2026-10-19 15:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `adddrop_items`
--

CREATE TABLE `adddrop_items` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `action` enum('Add','Drop') NOT NULL,
  `section_id` int(11) NOT NULL,
  `reason` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adddrop_items`
--

INSERT INTO `adddrop_items` (`id`, `request_id`, `action`, `section_id`, `reason`, `created_at`) VALUES
(9, 1, 'Drop', 19, 'Schedule conflict with capstone lab mentorship session.', '2026-10-19 15:30:25'),
(10, 1, 'Add', 20, 'Specialization elective requirement for Web Systems.', '2026-10-19 15:30:25'),
(11, 2, 'Add', 24, 'Authorized 3-unit graduating overload.', '2026-10-19 15:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `adddrop_requests`
--

CREATE TABLE `adddrop_requests` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `student_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `status` enum('Pending Dean Endorsement','Pending Registrar Authorization','Registrar Authorized','Declined','Completed') NOT NULL DEFAULT 'Pending Registrar Authorization',
  `reason` text NOT NULL,
  `pre_units` decimal(4,1) NOT NULL DEFAULT 18.0,
  `post_units` decimal(4,1) NOT NULL DEFAULT 18.0,
  `tuition_delta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `remarks_internal` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `decided_by` int(11) DEFAULT NULL,
  `decided_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adddrop_requests`
--

INSERT INTO `adddrop_requests` (`id`, `reference_no`, `student_id`, `term_id`, `status`, `reason`, `pre_units`, `post_units`, `tuition_delta`, `remarks_internal`, `submitted_at`, `decided_by`, `decided_at`, `created_at`, `updated_at`) VALUES
(1, 'ACA-26071', 5, 1, 'Pending Registrar Authorization', 'Schedule conflict with capstone lab mentorship session.', 18.0, 18.0, 0.00, 'Prerequisite validation auto-checked against Curricular Prospectus 2023 rev.', '2026-10-16 01:42:00', 1, '2026-10-19 23:19:05', '2026-10-19 14:13:57', '2026-10-19 15:30:25'),
(2, 'ACA-26072', 2, 1, 'Registrar Authorized', 'Graduating student unit overload for CS 412 Intelligent Systems.', 21.0, 24.0, 750.00, 'Overload approved by CIC Dean. Student on track for Magna Cum Laude.', '2026-10-17 03:15:00', 1, '2026-10-19 23:24:02', '2026-10-19 14:13:59', '2026-10-19 15:30:26'),
(3, 'ACA-26073', 6, 1, 'Completed', 'Curriculum realignment course addition after shifting.', 15.0, 18.0, 750.00, '\n[DECLINED]: Lacks official Dean endorsement letter.', '2026-10-18 02:05:00', 1, '2026-10-20 00:46:34', '2026-10-19 14:15:04', '2026-10-19 16:46:34');

-- --------------------------------------------------------

--
-- Table structure for table `adddrop_status_history`
--

CREATE TABLE `adddrop_status_history` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adddrop_status_history`
--

INSERT INTO `adddrop_status_history` (`id`, `request_id`, `from_status`, `to_status`, `remarks`, `changed_by`, `changed_at`) VALUES
(8, 2, 'Registrar Authorized', 'Completed', 'Committed via Batch SIS Sync.', 1, '2026-10-19 15:24:02'),
(9, 3, 'Pending Dean Endorsement', 'Declined', 'Lacks official Dean endorsement letter.', 1, '2026-10-19 15:29:44'),
(10, 1, NULL, 'Pending Dean Endorsement', 'Student submitted schedule alteration form.', 1, '2026-10-16 01:42:00'),
(11, 1, 'Pending Dean Endorsement', 'Pending Registrar Authorization', 'Dean endorsement received and authorized.', 1, '2026-10-16 02:15:00'),
(12, 3, 'Pending Dean Endorsement', 'Completed', 'Approved and officially committed to Student Information System (SIS).', 1, '2026-10-19 16:46:34');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `entity_type`, `entity_id`, `created_at`) VALUES
(1, 1, 'CORRECTION_STATUS_UPDATE: COR-2610506073 changed from \'Pending Review\' to \'Under Review\' (Remarks: Assigned to Registrar Evaluator for verification.)', 'correction_requests', 2, '2026-10-18 04:16:14'),
(2, 1, 'CORRECTION_STATUS_UPDATE: COR-2610506073 changed from \'Under Review\' to \'Approved\' (Remarks: Documents validated against PSA Registry. Approved for student SIS ledger correction.)', 'correction_requests', 2, '2026-10-18 04:16:24'),
(3, 1, 'CORRECTION_APPLIED_TO_STUDENT_RECORD: COR-2610506073 (Sex / Gender Marker) updated to \'Female\'', 'users', 2, '2026-10-18 04:17:11'),
(4, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-4CD71A32, channel: online) for request DOC-2610187216. Total: ₱150.00', 'request', 24, '2026-10-18 05:06:24'),
(5, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-DA4CAF36, channel: online) for request DOC-2610189098. Total: ₱620.00', 'request', 25, '2026-10-18 05:06:24'),
(6, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-9D4D1CFB, channel: online) for request DOC-2610188912. Total: ₱150.00', 'request', 26, '2026-10-18 05:11:35'),
(7, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-88F41FFE, channel: online) for request DOC-2610186203. Total: ₱150.00', 'request', 27, '2026-10-18 05:12:51'),
(8, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-73A5A9F8, channel: online) for request DOC-2610183980. Total: ₱80.00', 'request', 28, '2026-10-18 05:19:31'),
(9, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-FA89012B, channel: online) for request DOC-2610186065. Total: ₱150.00 | Remarks: Test', 'request', 29, '2026-10-18 12:55:15'),
(10, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-FBCAAA88, channel: online) for request DOC-2610184125. Total: ₱150.00 | Remarks: Test', 'request', 30, '2026-10-18 12:56:58'),
(11, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-586C81EE, channel: online) for request DOC-2610184774. Total: ₱150.00', 'request', 31, '2026-10-18 13:03:10'),
(12, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-20314D20, channel: online) for request DOC-2610188198. Total: ₱310.00 | Remarks: Testing 2 items', 'request', 32, '2026-10-18 13:09:54'),
(13, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-5EE7F60F, channel: online) for request DOC-2610184505. Total: ₱150.00', 'request', 33, '2026-10-18 13:15:36'),
(14, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-3F53EECF, channel: online) for request DOC-2610187589. Total: ₱430.00', 'request', 34, '2026-10-18 13:24:21'),
(15, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-C19E78EA, channel: online) for request DOC-2610184847. Total: ₱80.00', 'request', 35, '2026-10-18 13:34:52'),
(16, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-26DE2CFE, channel: online) for request DOC-2610189901. Total: ₱350.00', 'request', 36, '2026-10-18 13:45:35'),
(17, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-9B85CF9A, channel: online) for request DOC-2610186899. Total: ₱150.00', 'request', 37, '2026-10-18 13:53:14'),
(18, 2, 'Payment confirmed (mode: simulated, ref: TEST-PAY-584D2A9F, channel: online) for request DOC-2610181809. Total: ₱270.00', 'request', 38, '2026-10-18 14:11:21'),
(20, 1, 'CORRECTION_STATUS_UPDATE: COR-2610991680 changed from \'Pending Review\' to \'Approved\'', 'correction_requests', 3, '2026-10-19 06:43:35'),
(21, 1, 'CORRECTION_APPLIED_TO_STUDENT_RECORD: COR-2610991680 (Name Spelling / Legal Correction) updated to \'JOSHUA MANUEL M. PEARCE\'', 'correction_requests', 3, '2026-10-19 06:47:47'),
(22, 1, 'CORRECTION_STATUS_UPDATE: COR-260827 changed from \'Under Review\' to \'Approved\' (Remarks: PSA authenticated copy received. Awaiting secondary Form 137 validation.)', 'correction_requests', 1, '2026-10-19 06:55:57'),
(23, 1, 'CORRECTION_STATUS_UPDATE: COR-2610991680 changed from \'Pending Review\' to \'Approved\'', 'correction_requests', 3, '2026-10-19 07:25:12'),
(24, 1, 'CORRECTION_STATUS_UPDATE: COR-2610775104 changed from \'Pending Review\' to \'Approved\'', 'correction_requests', 4, '2026-10-19 07:35:54'),
(25, 2, 'PROFILE_UPDATE: Student updated personal contact and address details', 'user_profiles', 2, '2026-10-19 12:09:14'),
(26, 1, 'DPA_AUDIT: Admin viewed student profile for Joshua Pearce (2021-04182)', 'user_profiles', 2, '2026-10-19 12:09:15'),
(27, 1, 'CORRECTION_APPLIED_TO_STUDENT_RECORD: COR-260827 (Birthdate Correction) updated to \'May 18, 2003\'', 'correction_requests', 1, '2026-10-19 12:14:58'),
(28, 1, 'DPA_AUDIT: Admin viewed student profile for Joshua Pearce (2021-04182)', 'user_profiles', 2, '2026-10-19 13:42:15'),
(29, 1, 'DPA_AUDIT: Admin viewed student profile for Mark Lim (2020-00892)', 'user_profiles', 7, '2026-10-19 13:43:09'),
(30, 1, 'ADDDROP_APPROVE_COMMIT: Request ACA-26071 committed to SIS', 'adddrop_requests', 1, '2026-10-19 15:19:05'),
(31, 1, 'ADDDROP_BATCH_COMMIT_ALL: Committed 1 authorized requests to SIS', 'adddrop_requests', 0, '2026-10-19 15:24:02'),
(32, 1, 'ADDDROP_SAVE_MEMO: Updated internal remarks for request #3', 'adddrop_requests', 3, '2026-10-19 15:25:13'),
(33, 1, 'ADDDROP_DECLINE: Request ACA-26073 declined. Reason: Lacks official Dean endorsement letter.', 'adddrop_requests', 3, '2026-10-19 15:29:44'),
(34, 1, 'DEFICIENCY_NOTICE: Issued notice for TRA-26015: Official Transcript of Records requires dry seal from MSU-IIT Registrar.', 'shifting_requests', 2, '2026-10-19 16:18:50'),
(35, 1, 'SHIFTING_COMPLETE: Finalized ACA-26068 for user 6 into BSPSY', 'shifting_requests', 1, '2026-10-19 16:23:46'),
(36, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-10139)', 'user_profiles', 153, '2026-10-19 16:45:10'),
(37, 1, 'ADDDROP_APPROVE_COMMIT: Request ACA-26073 committed to SIS', 'adddrop_requests', 3, '2026-10-19 16:46:34'),
(38, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-10041)', 'user_profiles', 55, '2026-10-19 16:53:11'),
(39, 1, 'DPA_AUDIT: Admin viewed student profile for Joshua Pearce (2021-04182)', 'user_profiles', 2, '2026-10-19 16:56:16'),
(40, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-10082)', 'user_profiles', 96, '2026-10-19 16:56:37'),
(41, 1, 'GRADUATION_APPROVE: Approved ACA-26055 for Degree Conferment.', 'graduation_applications', 1, '2026-10-19 16:58:43'),
(42, 1, 'GRADUATION_ISSUE_DOCKET: Issued Conferment Docket #CDK-2026-2020-00892', 'graduation_applications', 1, '2026-10-19 16:59:03'),
(43, 1, 'GRADUATION_CLEARANCE_UPDATE: Set Library clearance to Clear. Remarks: Book replaced', 'graduation_applications', 4, '2026-10-19 17:13:36'),
(44, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-01892)', 'user_profiles', 19, '2026-10-19 17:15:23'),
(45, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-01892)', 'user_profiles', 19, '2026-10-19 17:16:42'),
(46, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-01892)', 'user_profiles', 19, '2026-10-19 17:35:02'),
(47, 1, 'DPA_AUDIT: Admin viewed student profile for   (2020-01892)', 'user_profiles', 19, '2026-10-19 17:39:30'),
(48, 1, 'GRADUATION_COMPLETE: Conferred graduation for Mark Lim (2020-00892).', 'graduation_applications', 1, '2026-10-19 18:07:20'),
(49, 1, 'GRADUATION_BOR_ENDORSE: Bulk endorsed 2 candidates for Board of Regents action.', 'graduation_applications', 0, '2026-10-19 18:11:41'),
(50, 1, 'Complete Readmission: ACA-26043 Lea B. Ramos', 'loa_requests', 1, '2026-10-19 18:28:54');

-- --------------------------------------------------------

--
-- Table structure for table `class_sections`
--

CREATE TABLE `class_sections` (
  `id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `section_code` varchar(50) NOT NULL,
  `days` varchar(30) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `room` varchar(100) NOT NULL,
  `instructor` varchar(150) NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT 40,
  `enrolled_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `class_sections`
--

INSERT INTO `class_sections` (`id`, `term_id`, `subject_id`, `section_code`, `days`, `start_time`, `end_time`, `room`, `instructor`, `capacity`, `enrolled_count`, `created_at`, `updated_at`) VALUES
(19, 1, 28, 'BSIT 2-A', 'MWF', '08:00:00', '09:00:00', 'ICT-302', 'Asst. Prof. Manuel Gomez', 40, 35, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(20, 1, 29, 'BSIT 2-C', 'TTh', '10:30:00', '12:00:00', 'CS-Lab 4', 'Assoc. Prof. Elena Santos', 40, 38, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(21, 1, 31, 'BSIT 2-A', 'MWF', '09:00:00', '10:00:00', 'ICT-301', 'Engr. Roberto Diaz', 40, 39, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(22, 1, 32, 'GE 1-B', 'MW', '13:00:00', '14:30:00', 'CAS-204', 'Prof. Carmela Cruz', 45, 42, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(23, 1, 33, 'PE 3-E', 'Fri', '13:00:00', '15:00:00', 'Gymnasium', 'Coach Dan Santos', 50, 48, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(24, 1, 34, 'BSCS 4-A', 'MWF', '13:00:00', '14:30:00', 'Lab 2', 'Dr. Tamara Cher R. Mercado', 30, 29, '2026-10-19 15:30:25', '2026-10-19 15:30:25');

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `dean_name` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `colleges`
--

INSERT INTO `colleges` (`id`, `code`, `name`, `dean_name`, `created_at`) VALUES
(1, 'CIC', 'College of Information and Computing', 'Dr. Tamara Cher R. Mercado', '2026-10-19 12:01:41'),
(2, 'CAS', 'College of Arts and Sciences', 'Dr. Eveyth P. Deligero', '2026-10-19 12:01:41'),
(3, 'COE', 'College of Engineering', 'Engr. Ricardo F. Fornis', '2026-10-19 12:01:41'),
(4, 'CTE', 'College of Teacher Education', 'Dr. Minerva C. Fabregas', '2026-10-19 12:01:41'),
(5, 'CBA', 'College of Business Administration', 'Dr. Bonifacio G. Gabales', '2026-10-19 12:01:41');

-- --------------------------------------------------------

--
-- Table structure for table `correction_categories`
--

CREATE TABLE `correction_categories` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(50) NOT NULL,
  `requirements` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `correction_categories`
--

INSERT INTO `correction_categories` (`id`, `code`, `label`, `description`, `icon`, `requirements`, `is_active`, `created_at`) VALUES
(1, 'name', 'Name Spelling / Legal Correction', 'Surname, first name, middle name, or suffix discrepancy alignment with official civil registrar.', 'badge', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated PSA/NSO Certificate of Live Birth showing registered registry number and full name.\"},{\"icon\":\"badge\",\"title\":\"Two Government Photo IDs\",\"desc\":\"Two valid government photo IDs (e.g. Passport, Driver’s License, UMID, PhilID).\"},{\"icon\":\"description\",\"title\":\"Joint Affidavit (if applicable)\",\"desc\":\"Joint Affidavit of Two Disinterested Persons if discrepancy involves surname transposition.\"}]', 1, '2026-10-17 16:53:47'),
(2, 'birthdate', 'Birthdate Correction', 'Discrepancy in date, month, or birth year recorded in the SIS student ledger.', 'calendar_month', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated Philippine Statistics Authority Certificate of Live Birth.\"},{\"icon\":\"school\",\"title\":\"Form 137 / SF10\",\"desc\":\"Certified True Copy of High School Permanent Record (Form 137-A) bearing matching birth date.\"},{\"icon\":\"badge\",\"title\":\"Government Photo ID\",\"desc\":\"Valid government photo ID verifying official birthdate.\"}]', 1, '2026-10-17 16:53:47'),
(3, 'gender', 'Sex / Gender Marker', 'Correction of official sex or gender marker on school records.', 'transgender', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated PSA Birth Certificate indicating correct biological sex marker.\"},{\"icon\":\"gavel\",\"title\":\"Annotated Civil Registry\",\"desc\":\"Annotated PSA record if sex marker was legally corrected pursuant to R.A. 9048 or court decree.\"},{\"icon\":\"badge\",\"title\":\"Valid Government ID\",\"desc\":\"Primary government ID matching updated record.\"}]', 1, '2026-10-17 16:53:47'),
(4, 'place_of_birth', 'Place of Birth', 'Discrepancy in city, municipality, or province of birth.', 'location_city', '[{\"icon\":\"verified\",\"title\":\"PSA Birth Certificate\",\"desc\":\"Authenticated PSA Birth Certificate showing exact city/municipality of birth.\"},{\"icon\":\"badge\",\"title\":\"Valid Government ID\",\"desc\":\"Valid government ID reflecting registered place of birth.\"}]', 1, '2026-10-17 16:53:47'),
(5, 'civil_status', 'Civil Status Update', 'Marriage status change, adoption of spouse surname, or legal decree updates.', 'family_restroom', '[{\"icon\":\"favorite\",\"title\":\"PSA Marriage Certificate\",\"desc\":\"Authenticated PSA Marriage Certificate for married female students adopting husband’s surname.\"},{\"icon\":\"gavel\",\"title\":\"Court Legal Decree\",\"desc\":\"Official Court Decree or Annotated PSA certificate (for legal annulment or legal name adoption).\"},{\"icon\":\"badge\",\"title\":\"Updated Government ID\",\"desc\":\"Valid government ID reflecting the newly adopted civil status or legal name.\"}]', 1, '2026-10-17 16:53:47'),
(6, 'curriculum', 'Program, Curriculum, or Subject Code Update', 'Catalog year realignment, prerequisite tagging, or course credit fix.', 'auto_stories', '[{\"icon\":\"account_balance\",\"title\":\"Dean / Chair Endorsement\",\"desc\":\"Explicit formal endorsement memorandum from College Dean or Academic Department Chair.\"},{\"icon\":\"fact_check\",\"title\":\"Approved Curriculum Checklist\",\"desc\":\"Official signed curriculum prospectus showing catalog requirement shift.\"},{\"icon\":\"grade\",\"title\":\"Grade Verification Sheet\",\"desc\":\"Instructor grade validation sheet if subject prerequisite tagging is involved.\"}]', 1, '2026-10-17 16:53:47'),
(7, 'other', 'Other Ledger Discrepancy', 'Any other formal academic or demographic record rectifications.', 'help_outline', '[{\"icon\":\"description\",\"title\":\"Official Letter Petition\",\"desc\":\"Formal letter addressed to the University Registrar stating discrepancy and desired alignment.\"},{\"icon\":\"verified\",\"title\":\"Supporting Credentials\",\"desc\":\"Official university or government certifications proving accurate ledger data.\"}]', 0, '2026-10-17 16:53:47');

-- --------------------------------------------------------

--
-- Table structure for table `correction_documents`
--

CREATE TABLE `correction_documents` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `stored_name` varchar(255) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `size_bytes` bigint(20) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `correction_documents`
--

INSERT INTO `correction_documents` (`id`, `request_id`, `original_name`, `stored_name`, `mime_type`, `size_bytes`, `uploaded_at`) VALUES
(1, 1, 'PSA_Birth_Certificate_JoshuaPearce.pdf', 'doc_demo_psa_birth.pdf', 'application/pdf', 2415919, '2026-10-13 16:53:47'),
(2, 2, 'test_doc.pdf', 'doc_1792296862_06d2d4ce48ad791e.pdf', 'application/pdf', 704, '2026-10-18 04:14:22'),
(3, 3, 'temp_test_doc.pdf', 'doc_1792340498_05b47256b693c550.pdf', 'application/pdf', 30, '2026-10-18 16:21:38'),
(4, 4, 'Figure_2_Context_Level_DFD_BW.png', 'doc_1792393146_348e638faf65472d.png', 'image/png', 250171, '2026-10-19 06:59:06');

-- --------------------------------------------------------

--
-- Table structure for table `correction_requests`
--

CREATE TABLE `correction_requests` (
  `id` int(11) NOT NULL,
  `tracking_code` varchar(30) NOT NULL,
  `student_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `current_value` varchar(255) NOT NULL,
  `proposed_value` varchar(255) NOT NULL,
  `contact_number` varchar(30) NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Pending Review','Under Review','Needs More Info','Approved','Declined','Completed') NOT NULL DEFAULT 'Pending Review',
  `registrar_remarks` text DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `correction_requests`
--

INSERT INTO `correction_requests` (`id`, `tracking_code`, `student_id`, `category_id`, `current_value`, `proposed_value`, `contact_number`, `reason`, `status`, `registrar_remarks`, `reviewed_by`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(1, 'COR-260827', 2, 2, 'May 14, 2003', 'May 18, 2003', '+63 947 882 1094', 'Official PSA Certificate of Live Birth registered in Davao City indicates birth date as May 18, 2003 instead of May 14.', 'Completed', 'PSA authenticated copy received. Awaiting secondary Form 137 validation. [Applied to SIS Ledger]', 1, '2026-10-19 20:14:58', '2026-10-13 16:53:47', '2026-10-19 12:14:58'),
(2, 'COR-2610506073', 2, 3, 'Male', 'Female', '+63 947 882 1094', 'Typographical error on gender classification upon initial high school registration.', 'Completed', 'Documents validated against PSA Registry. Approved for student SIS ledger correction. [Applied]', 1, '2026-10-18 12:17:11', '2026-10-18 04:14:22', '2026-10-18 04:17:11'),
(3, 'COR-2610991680', 2, 1, 'JOSHUA MANUEL PEARCE', 'JOSHUA MANUEL M. PEARCE', '+63 947 882 1094', 'Correction of middle name spelling to align with official PSA Birth Certificate.', 'Approved', NULL, 1, '2026-10-19 15:25:11', '2026-10-18 16:21:38', '2026-10-19 07:25:11'),
(4, 'COR-2610775104', 2, 3, 'Male', 'Female', '+63 947 882 1094', 'sample qwertyuiopasdfghjkzlxcvbnm', 'Approved', NULL, 1, '2026-10-19 15:35:54', '2026-10-19 06:59:06', '2026-10-19 07:35:54'),
(5, 'COR-2609081120', 2, 1, 'Pearce, Joshua', 'Pearce, Joshua Andrew', '09171234567', 'Middle name addition per PSA Birth Certificate', 'Completed', NULL, NULL, NULL, '2026-09-08 03:20:00', '2026-09-08 03:20:00'),
(6, 'COR-2609221415', 2, 2, '2002-05-15', '2002-05-14', '09171234567', 'Day discrepancy adjustment matching civil registrar records', 'Approved', NULL, NULL, NULL, '2026-09-22 06:15:00', '2026-09-22 06:15:00'),
(7, 'COR-2610040930', 2, 4, 'Davao', 'Davao City', '09171234567', 'Standardization of municipality to city format', 'Needs More Info', NULL, NULL, NULL, '2026-10-04 01:30:00', '2026-10-04 01:30:00'),
(8, 'COR-2610161645', 2, 6, 'BSCS-2020', 'BSCS-2021-V2', '09171234567', 'Curriculum version alignment for senior residency', 'Under Review', NULL, NULL, NULL, '2026-10-16 08:45:00', '2026-10-16 08:45:00');

-- --------------------------------------------------------

--
-- Table structure for table `correction_status_history`
--

CREATE TABLE `correction_status_history` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `correction_status_history`
--

INSERT INTO `correction_status_history` (`id`, `request_id`, `from_status`, `to_status`, `remarks`, `changed_by`, `changed_at`) VALUES
(1, 1, NULL, 'Pending Review', 'Correction petition filed by student via online portal.', 2, '2026-10-13 16:53:47'),
(2, 1, 'Pending Review', 'Under Review', 'Assigned to Registrar Evaluator Window 2 for civil registry verification.', 1, '2026-10-15 16:53:47'),
(3, 2, NULL, 'Pending Review', 'Correction petition filed by student with supporting documents.', 2, '2026-10-18 04:14:22'),
(4, 2, 'Pending Review', 'Under Review', 'Assigned to Registrar Evaluator for verification.', 1, '2026-10-18 04:16:14'),
(5, 2, 'Under Review', 'Approved', 'Documents validated against PSA Registry. Approved for student SIS ledger correction.', 1, '2026-10-18 04:16:24'),
(6, 2, 'Approved', 'Completed', 'Applied to student\'s official SIS record by Evaluator ID 1 on 2026-10-18 06:17:11', 1, '2026-10-18 04:17:11'),
(7, 3, NULL, 'Pending Review', 'Correction petition filed by student with supporting documents.', 2, '2026-10-18 16:21:38'),
(9, 3, 'Pending Review', 'Approved', 'Status updated to Approved by Registrar.', 1, '2026-10-19 06:43:35'),
(10, 3, 'Approved', 'Completed', 'Applied to student\'s official SIS record by Evaluator ID 1 on 2026-10-19 08:47:47', 1, '2026-10-19 06:47:47'),
(11, 1, 'Under Review', 'Approved', 'PSA authenticated copy received. Awaiting secondary Form 137 validation.', 1, '2026-10-19 06:55:57'),
(12, 4, NULL, 'Pending Review', 'Correction petition filed by student with supporting documents.', 2, '2026-10-19 06:59:06'),
(13, 3, 'Pending Review', 'Approved', 'Status updated to Approved by Registrar.', 1, '2026-10-19 07:25:12'),
(14, 4, 'Pending Review', 'Approved', 'Status updated to Approved by Registrar.', 1, '2026-10-19 07:35:54'),
(15, 1, 'Approved', 'Completed', 'Applied to student\'s official SIS record by Evaluator ID 1 on 2026-10-19 14:14:58', 1, '2026-10-19 12:14:58');

-- --------------------------------------------------------

--
-- Table structure for table `credit_evaluations`
--

CREATE TABLE `credit_evaluations` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `source_subject_code` varchar(50) NOT NULL,
  `source_title` varchar(255) NOT NULL,
  `source_grade` decimal(3,2) NOT NULL,
  `source_units` decimal(3,1) NOT NULL,
  `target_subject_id` int(11) DEFAULT NULL,
  `equivalency_type` enum('1:1','Special Credit','Prereq Satisfied','Not Credited') NOT NULL DEFAULT '1:1',
  `evaluator_id` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `credit_evaluations`
--

INSERT INTO `credit_evaluations` (`id`, `request_id`, `source_subject_code`, `source_title`, `source_grade`, `source_units`, `target_subject_id`, `equivalency_type`, `evaluator_id`, `remarks`, `created_at`) VALUES
(1, 1, 'GE 101', 'Understanding the Self', 1.25, 3.0, 37, '1:1', 1, 'BS Psych GE Core Req', '2026-10-19 15:37:09'),
(2, 1, 'GE 102', 'Readings in Philippine History', 1.00, 3.0, 5, '1:1', 1, 'BS Psych GE Core Req', '2026-10-19 15:37:09'),
(3, 1, 'COMM 104', 'Communication Media', 1.50, 3.0, 40, 'Special Credit', 1, 'Syllabus Comparison: 88% Competency Overlap Approved by Dept Chair', '2026-10-19 15:37:09'),
(4, 1, 'NATSCI 101', 'General Biological Sciences (Lecture & Lab)', 1.50, 5.0, 43, 'Prereq Satisfied', 1, 'Enables Neuroanatomy', '2026-10-19 15:37:09'),
(5, 1, 'COMM 101', 'Intro to Communication', 1.75, 3.0, NULL, '1:1', 1, 'Free Elective Credited', '2026-10-19 15:37:09'),
(6, 1, 'GE 103', 'The Contemporary World', 1.25, 3.0, NULL, '1:1', 1, 'BS Psych GE Core Req', '2026-10-19 15:37:09'),
(7, 1, 'PE 1', 'Movement Competency Training', 1.00, 2.0, NULL, '1:1', 1, 'Physical Education Requirement', '2026-10-19 15:37:09'),
(8, 1, 'PE 2', 'Fitness Exercises', 1.25, 2.0, NULL, '1:1', 1, 'Physical Education Requirement', '2026-10-19 15:37:09'),
(9, 1, 'NSTP 1', 'Civic Welfare Training Service 1', 1.00, 3.0, NULL, '1:1', 1, 'National Service Training', '2026-10-19 15:37:09'),
(10, 1, 'NSTP 2', 'Civic Welfare Training Service 2', 1.25, 5.0, NULL, 'Special Credit', 1, 'NSTP Completion Verified', '2026-10-19 15:37:09'),
(11, 2, 'MATH 101', 'Calculus 1', 1.75, 4.0, NULL, '1:1', 1, 'Equivalent to Math 21', '2026-10-19 15:37:10'),
(12, 2, 'ENG 1', 'Engineering Graphics', 1.50, 2.0, NULL, 'Special Credit', 1, 'CAD Competency Certified', '2026-10-19 15:37:10'),
(13, 3, 'EDUC 101', 'Child & Adolescent Development', 1.50, 3.0, NULL, '1:1', 1, 'BEED Core Req', '2026-10-19 15:37:11');

-- --------------------------------------------------------

--
-- Table structure for table `curricula`
--

CREATE TABLE `curricula` (
  `id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `effective_year` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `curricula`
--

INSERT INTO `curricula` (`id`, `program_id`, `version`, `effective_year`, `created_at`) VALUES
(1, 1, '2021 Revised Curriculum', 2021, '2026-10-19 12:01:42'),
(2, 2, '2021 Revised Curriculum', 2021, '2026-10-19 12:01:42'),
(3, 4, '2022 CMO-34 Alignment', 2022, '2026-10-19 12:01:42'),
(4, 5, '2020 CHED Compliant', 2020, '2026-10-19 12:01:42'),
(5, 7, '2020 CMO-92 OBE Framework', 2020, '2026-10-19 12:01:42'),
(6, 10, '2021 CMO-75 K-12 Enhanced', 2021, '2026-10-19 12:01:42'),
(7, 12, '2021 Revised Curriculum', 2021, '2026-10-19 12:01:42');

-- --------------------------------------------------------

--
-- Table structure for table `curriculum_requirements`
--

CREATE TABLE `curriculum_requirements` (
  `id` int(11) NOT NULL,
  `curriculum_id` int(11) NOT NULL,
  `category` enum('Major','General Education','Practicum','Electives') NOT NULL,
  `required_units` decimal(5,1) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `curriculum_requirements`
--

INSERT INTO `curriculum_requirements` (`id`, `curriculum_id`, `category`, `required_units`, `description`, `created_at`) VALUES
(25, 5, 'Major', 88.0, 'Major Professional Courses & Capstone Project I & II', '2026-10-19 16:52:32'),
(26, 5, 'General Education', 36.0, 'General Education Core Mandated Competencies', '2026-10-19 16:52:32'),
(27, 5, 'Practicum', 6.0, 'Practicum / On-the-Job Training (480 Hours)', '2026-10-19 16:52:33'),
(28, 5, 'Electives', 18.0, 'Technical & Cognate Electives (Structural Engineering Track)', '2026-10-19 16:52:33'),
(29, 1, 'Major', 86.0, 'CS Core & Algorithms Sequence', '2026-10-19 16:52:33'),
(30, 1, 'General Education', 36.0, 'General Education Core', '2026-10-19 16:52:33'),
(31, 1, 'Practicum', 6.0, 'Industry Internship (480 Hours)', '2026-10-19 16:52:33'),
(32, 1, 'Electives', 18.0, 'Intelligent Systems & Data Science Track', '2026-10-19 16:52:33'),
(33, 2, 'Major', 85.0, 'IT Systems, Networking & Capstone II', '2026-10-19 16:52:33'),
(34, 2, 'General Education', 36.0, 'General Education Core', '2026-10-19 16:52:33'),
(35, 2, 'Practicum', 6.0, 'Industry Practicum (480 Hours)', '2026-10-19 16:52:33'),
(36, 2, 'Electives', 16.0, 'Enterprise & Web Development Track', '2026-10-19 16:52:33');

-- --------------------------------------------------------

--
-- Table structure for table `deficiency_notices`
--

CREATE TABLE `deficiency_notices` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `issued_by` int(11) DEFAULT NULL,
  `issued_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deficiency_notices`
--

INSERT INTO `deficiency_notices` (`id`, `request_id`, `student_id`, `message`, `issued_by`, `issued_at`, `resolved_at`) VALUES
(1, 2, 7, 'Official Transcript of Records requires dry seal from MSU-IIT Registrar.', 1, '2026-10-19 16:18:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `document_types`
--

CREATE TABLE `document_types` (
  `id` int(11) NOT NULL,
  `category` enum('Academic Records','Certifications','Graduation & Transfer') NOT NULL,
  `name` varchar(100) NOT NULL,
  `base_fee` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_types`
--

INSERT INTO `document_types` (`id`, `category`, `name`, `base_fee`, `is_active`) VALUES
(1, 'Academic Records', 'Transcript of Records (TOR)', 150.00, 1),
(2, 'Academic Records', 'Authentication & Certified Copies (CAV)', 80.00, 1),
(3, 'Certifications', 'Certificate of Enrollment (COE)', 80.00, 1),
(4, 'Certifications', 'Certificate of Good Moral Character', 50.00, 1),
(5, 'Certifications', 'Certificate of Grades', 100.00, 1),
(6, 'Graduation & Transfer', 'Honorable Dismissal', 150.00, 1),
(7, 'Graduation & Transfer', 'Diploma Re-issue / Tracking', 350.00, 1),
(8, 'Graduation & Transfer', 'Certificate of Graduation', 100.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `status` enum('Enrolled','Dropped') NOT NULL DEFAULT 'Enrolled',
  `grade` varchar(10) DEFAULT NULL,
  `enrolled_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `student_id`, `section_id`, `term_id`, `status`, `grade`, `enrolled_at`, `updated_at`) VALUES
(15, 5, 19, 1, 'Enrolled', NULL, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(16, 5, 21, 1, 'Enrolled', NULL, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(17, 5, 22, 1, 'Enrolled', NULL, '2026-10-19 15:30:25', '2026-10-19 15:30:25'),
(18, 5, 23, 1, 'Enrolled', NULL, '2026-10-19 15:30:25', '2026-10-19 15:30:25');

-- --------------------------------------------------------

--
-- Table structure for table `graduation_applications`
--

CREATE TABLE `graduation_applications` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `student_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `status` enum('Under Audit','Deficient','Cleared','Ready for Conferment','Endorsed','Completed','Declined') NOT NULL DEFAULT 'Under Audit',
  `gwa` decimal(3,2) DEFAULT NULL,
  `honors` varchar(50) DEFAULT NULL,
  `audited_by` int(11) DEFAULT NULL,
  `audited_at` datetime DEFAULT NULL,
  `conferment_docket_no` varchar(100) DEFAULT NULL,
  `conferment_issued_at` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `graduation_applications`
--

INSERT INTO `graduation_applications` (`id`, `reference_no`, `student_id`, `batch_id`, `status`, `gwa`, `honors`, `audited_by`, `audited_at`, `conferment_docket_no`, `conferment_issued_at`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 'ACA-26055', 5, 1, 'Completed', 1.34, 'Magna Cum Laude', 1, '2026-10-20 02:07:20', 'CDK-2026-2020-00892', '2026-10-20 00:59:03', 'Cleared and recommended for academic degree conferment.', '2026-10-19 16:37:36', '2026-10-19 18:07:20'),
(2, 'ACA-26056', 12, 1, 'Endorsed', 1.18, 'Summa Cum Laude', 1, '2026-10-20 02:11:41', 'CDK-2026-01124', '2026-10-17 15:30:00', 'BOR Resolution Endorsed.', '2026-10-19 16:37:36', '2026-10-19 18:11:41'),
(3, 'ACA-26057', 13, 1, 'Endorsed', 1.62, 'Magna Cum Laude', 1, '2026-10-20 02:11:41', 'CDK-2026-04421', '2026-10-17 16:00:00', 'BOR Resolution Endorsed.', '2026-10-19 16:37:36', '2026-10-19 18:11:41'),
(4, 'ACA-26058', 14, 1, 'Deficient', 1.78, 'None', 1, '2026-10-19 14:20:00', NULL, NULL, 'Deficiency Audit Flag: 3 Units Incomplete in Capstone Project II; Main Library Hold.', '2026-10-19 16:37:36', '2026-10-19 16:37:36'),
(5, 'ACA-26059', 3, 1, 'Ready for Conferment', 1.45, 'Magna Cum Laude', 1, '2026-10-18 10:00:00', 'CDK-2026-01421', '2026-10-18 14:30:00', 'Curriculum audit cleared.', '2026-10-19 16:37:36', '2026-10-19 16:37:36'),
(6, 'ACA-26106', 15, 1, 'Cleared', 1.51, 'Cum Laude', 1, '2026-10-20 00:37:37', NULL, NULL, NULL, '2026-10-19 16:37:37', '2026-10-19 16:37:37'),
(7, 'ACA-26107', 16, 1, 'Cleared', 1.60, 'Cum Laude', 1, '2026-10-20 00:37:38', NULL, NULL, NULL, '2026-10-19 16:37:38', '2026-10-19 16:37:38'),
(8, 'ACA-26108', 17, 1, 'Cleared', 2.12, 'None', 1, '2026-10-20 00:37:38', NULL, NULL, NULL, '2026-10-19 16:37:38', '2026-10-19 16:37:38'),
(9, 'ACA-26109', 18, 1, 'Cleared', 1.32, 'Magna Cum Laude', 1, '2026-10-20 00:37:38', NULL, NULL, NULL, '2026-10-19 16:37:38', '2026-10-19 16:37:38'),
(10, 'ACA-26110', 19, 1, 'Cleared', 2.13, 'None', 1, '2026-10-20 00:37:38', NULL, NULL, NULL, '2026-10-19 16:37:38', '2026-10-19 16:37:38'),
(11, 'ACA-26111', 20, 1, 'Cleared', 2.44, 'None', 1, '2026-10-20 00:37:38', NULL, NULL, NULL, '2026-10-19 16:37:38', '2026-10-19 16:37:38'),
(12, 'ACA-26112', 21, 1, 'Cleared', 1.54, 'Cum Laude', 1, '2026-10-20 00:37:38', NULL, NULL, NULL, '2026-10-19 16:37:38', '2026-10-19 16:37:38'),
(13, 'ACA-26113', 22, 1, 'Cleared', 1.63, 'Cum Laude', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(14, 'ACA-26114', 23, 1, 'Cleared', 1.51, 'Cum Laude', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(15, 'ACA-26115', 24, 1, 'Cleared', 1.83, 'None', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(16, 'ACA-26116', 25, 1, 'Cleared', 1.30, 'Magna Cum Laude', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(17, 'ACA-26117', 26, 1, 'Cleared', 1.58, 'Cum Laude', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(18, 'ACA-26118', 27, 1, 'Cleared', 2.01, 'None', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(19, 'ACA-26119', 28, 1, 'Cleared', 1.59, 'Cum Laude', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(20, 'ACA-26120', 29, 1, 'Cleared', 1.96, 'None', 1, '2026-10-20 00:37:39', NULL, NULL, NULL, '2026-10-19 16:37:39', '2026-10-19 16:37:39'),
(21, 'ACA-26121', 30, 1, 'Cleared', 1.29, 'Magna Cum Laude', 1, '2026-10-20 00:37:40', NULL, NULL, NULL, '2026-10-19 16:37:40', '2026-10-19 16:37:40'),
(22, 'ACA-26122', 31, 1, 'Cleared', 2.22, 'None', 1, '2026-10-20 00:37:40', NULL, NULL, NULL, '2026-10-19 16:37:40', '2026-10-19 16:37:40'),
(23, 'ACA-26123', 32, 1, 'Cleared', 2.16, 'None', 1, '2026-10-20 00:37:40', NULL, NULL, NULL, '2026-10-19 16:37:40', '2026-10-19 16:37:40'),
(24, 'ACA-26124', 33, 1, 'Cleared', 1.52, 'Cum Laude', 1, '2026-10-20 00:37:40', NULL, NULL, NULL, '2026-10-19 16:37:40', '2026-10-19 16:37:40'),
(25, 'ACA-26125', 34, 1, 'Cleared', 2.36, 'None', 1, '2026-10-20 00:37:40', NULL, NULL, NULL, '2026-10-19 16:37:40', '2026-10-19 16:37:40'),
(26, 'ACA-26126', 35, 1, 'Cleared', 1.73, 'Cum Laude', 1, '2026-10-20 00:37:41', NULL, NULL, NULL, '2026-10-19 16:37:41', '2026-10-19 16:37:41'),
(27, 'ACA-26127', 36, 1, 'Cleared', 2.39, 'None', 1, '2026-10-20 00:37:41', NULL, NULL, NULL, '2026-10-19 16:37:41', '2026-10-19 16:37:41'),
(28, 'ACA-26128', 37, 1, 'Cleared', 2.54, 'None', 1, '2026-10-20 00:37:41', NULL, NULL, NULL, '2026-10-19 16:37:41', '2026-10-19 16:37:41'),
(29, 'ACA-26129', 38, 1, 'Cleared', 1.64, 'Cum Laude', 1, '2026-10-20 00:37:41', NULL, NULL, NULL, '2026-10-19 16:37:41', '2026-10-19 16:37:41'),
(30, 'ACA-26130', 39, 1, 'Cleared', 2.52, 'None', 1, '2026-10-20 00:37:41', NULL, NULL, NULL, '2026-10-19 16:37:41', '2026-10-19 16:37:41'),
(31, 'ACA-26131', 40, 1, 'Cleared', 2.52, 'None', 1, '2026-10-20 00:37:42', NULL, NULL, NULL, '2026-10-19 16:37:42', '2026-10-19 16:37:42'),
(32, 'ACA-26132', 41, 1, 'Cleared', 1.80, 'None', 1, '2026-10-20 00:37:42', NULL, NULL, NULL, '2026-10-19 16:37:42', '2026-10-19 16:37:42'),
(33, 'ACA-26133', 42, 1, 'Cleared', 1.33, 'Magna Cum Laude', 1, '2026-10-20 00:37:42', NULL, NULL, NULL, '2026-10-19 16:37:42', '2026-10-19 16:37:42'),
(34, 'ACA-26134', 43, 1, 'Cleared', 1.44, 'Magna Cum Laude', 1, '2026-10-20 00:37:42', NULL, NULL, NULL, '2026-10-19 16:37:42', '2026-10-19 16:37:42'),
(35, 'ACA-26135', 44, 1, 'Cleared', 2.00, 'None', 1, '2026-10-20 00:37:42', NULL, NULL, NULL, '2026-10-19 16:37:42', '2026-10-19 16:37:42'),
(36, 'ACA-26136', 45, 1, 'Cleared', 2.44, 'None', 1, '2026-10-20 00:37:42', NULL, NULL, NULL, '2026-10-19 16:37:42', '2026-10-19 16:37:42'),
(37, 'ACA-26137', 46, 1, 'Cleared', 2.30, 'None', 1, '2026-10-20 00:37:43', NULL, NULL, NULL, '2026-10-19 16:37:43', '2026-10-19 16:37:43'),
(38, 'ACA-26138', 47, 1, 'Cleared', 1.99, 'None', 1, '2026-10-20 00:37:43', NULL, NULL, NULL, '2026-10-19 16:37:43', '2026-10-19 16:37:43'),
(39, 'ACA-26139', 48, 1, 'Cleared', 2.11, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(40, 'ACA-26140', 49, 1, 'Cleared', 1.98, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(41, 'ACA-26141', 50, 1, 'Cleared', 2.56, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(42, 'ACA-26142', 51, 1, 'Cleared', 2.05, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(43, 'ACA-26143', 52, 1, 'Cleared', 2.51, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(44, 'ACA-26144', 53, 1, 'Cleared', 2.13, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(45, 'ACA-26145', 54, 1, 'Cleared', 1.89, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(46, 'ACA-26146', 55, 1, 'Cleared', 2.54, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(47, 'ACA-26147', 56, 1, 'Deficient', 1.78, 'None', 1, '2026-10-20 00:37:44', NULL, NULL, NULL, '2026-10-19 16:37:44', '2026-10-19 16:37:44'),
(48, 'ACA-26148', 57, 1, 'Cleared', 1.47, 'Cum Laude', 1, '2026-10-20 00:37:45', NULL, NULL, NULL, '2026-10-19 16:37:45', '2026-10-19 16:37:45'),
(49, 'ACA-26149', 58, 1, 'Cleared', 2.19, 'None', 1, '2026-10-20 00:37:45', NULL, NULL, NULL, '2026-10-19 16:37:45', '2026-10-19 16:37:45'),
(50, 'ACA-26150', 59, 1, 'Cleared', 1.83, 'None', 1, '2026-10-20 00:37:45', NULL, NULL, NULL, '2026-10-19 16:37:45', '2026-10-19 16:37:45'),
(51, 'ACA-26151', 60, 1, 'Cleared', 2.04, 'None', 1, '2026-10-20 00:37:45', NULL, NULL, NULL, '2026-10-19 16:37:45', '2026-10-19 16:37:45'),
(52, 'ACA-26152', 61, 1, 'Cleared', 2.07, 'None', 1, '2026-10-20 00:37:45', NULL, NULL, NULL, '2026-10-19 16:37:45', '2026-10-19 16:37:45'),
(53, 'ACA-26153', 62, 1, 'Cleared', 2.37, 'None', 1, '2026-10-20 00:37:45', NULL, NULL, NULL, '2026-10-19 16:37:45', '2026-10-19 16:37:45'),
(54, 'ACA-26154', 63, 1, 'Cleared', 1.67, 'Cum Laude', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(55, 'ACA-26155', 64, 1, 'Cleared', 2.65, 'None', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(56, 'ACA-26156', 65, 1, 'Cleared', 2.57, 'None', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(57, 'ACA-26157', 66, 1, 'Cleared', 2.57, 'None', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(58, 'ACA-26158', 67, 1, 'Cleared', 2.35, 'None', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(59, 'ACA-26159', 68, 1, 'Cleared', 2.40, 'None', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(60, 'ACA-26160', 69, 1, 'Cleared', 1.41, 'Magna Cum Laude', 1, '2026-10-20 00:37:46', NULL, NULL, NULL, '2026-10-19 16:37:46', '2026-10-19 16:37:46'),
(61, 'ACA-26161', 70, 1, 'Cleared', 1.54, 'Cum Laude', 1, '2026-10-20 00:37:47', NULL, NULL, NULL, '2026-10-19 16:37:47', '2026-10-19 16:37:47'),
(62, 'ACA-26162', 71, 1, 'Cleared', 2.33, 'None', 1, '2026-10-20 00:37:47', NULL, NULL, NULL, '2026-10-19 16:37:47', '2026-10-19 16:37:47'),
(63, 'ACA-26163', 72, 1, 'Cleared', 1.77, 'None', 1, '2026-10-20 00:37:47', NULL, NULL, NULL, '2026-10-19 16:37:47', '2026-10-19 16:37:47'),
(64, 'ACA-26164', 73, 1, 'Cleared', 1.26, 'Magna Cum Laude', 1, '2026-10-20 00:37:47', NULL, NULL, NULL, '2026-10-19 16:37:47', '2026-10-19 16:37:47'),
(65, 'ACA-26165', 74, 1, 'Cleared', 2.38, 'None', 1, '2026-10-20 00:37:47', NULL, NULL, NULL, '2026-10-19 16:37:47', '2026-10-19 16:37:47'),
(66, 'ACA-26166', 75, 1, 'Cleared', 2.59, 'None', 1, '2026-10-20 00:37:48', NULL, NULL, NULL, '2026-10-19 16:37:48', '2026-10-19 16:37:48'),
(67, 'ACA-26167', 76, 1, 'Cleared', 2.58, 'None', 1, '2026-10-20 00:37:49', NULL, NULL, NULL, '2026-10-19 16:37:49', '2026-10-19 16:37:49'),
(68, 'ACA-26168', 77, 1, 'Cleared', 1.55, 'Cum Laude', 1, '2026-10-20 00:37:49', NULL, NULL, NULL, '2026-10-19 16:37:49', '2026-10-19 16:37:49'),
(69, 'ACA-26169', 78, 1, 'Cleared', 2.65, 'None', 1, '2026-10-20 00:37:49', NULL, NULL, NULL, '2026-10-19 16:37:49', '2026-10-19 16:37:49'),
(70, 'ACA-26170', 79, 1, 'Cleared', 2.26, 'None', 1, '2026-10-20 00:37:49', NULL, NULL, NULL, '2026-10-19 16:37:49', '2026-10-19 16:37:49'),
(71, 'ACA-26171', 80, 1, 'Cleared', 2.43, 'None', 1, '2026-10-20 00:37:50', NULL, NULL, NULL, '2026-10-19 16:37:50', '2026-10-19 16:37:50'),
(72, 'ACA-26172', 81, 1, 'Cleared', 1.48, 'Cum Laude', 1, '2026-10-20 00:37:50', NULL, NULL, NULL, '2026-10-19 16:37:50', '2026-10-19 16:37:50'),
(73, 'ACA-26173', 82, 1, 'Cleared', 2.27, 'None', 1, '2026-10-20 00:37:51', NULL, NULL, NULL, '2026-10-19 16:37:51', '2026-10-19 16:37:51'),
(74, 'ACA-26174', 83, 1, 'Cleared', 1.97, 'None', 1, '2026-10-20 00:37:51', NULL, NULL, NULL, '2026-10-19 16:37:51', '2026-10-19 16:37:51'),
(75, 'ACA-26175', 84, 1, 'Cleared', 2.04, 'None', 1, '2026-10-20 00:37:51', NULL, NULL, NULL, '2026-10-19 16:37:51', '2026-10-19 16:37:51'),
(76, 'ACA-26176', 85, 1, 'Cleared', 2.55, 'None', 1, '2026-10-20 00:37:51', NULL, NULL, NULL, '2026-10-19 16:37:51', '2026-10-19 16:37:51'),
(77, 'ACA-26177', 86, 1, 'Cleared', 1.84, 'None', 1, '2026-10-20 00:37:51', NULL, NULL, NULL, '2026-10-19 16:37:51', '2026-10-19 16:37:51'),
(78, 'ACA-26178', 87, 1, 'Cleared', 1.26, 'Magna Cum Laude', 1, '2026-10-20 00:37:51', NULL, NULL, NULL, '2026-10-19 16:37:51', '2026-10-19 16:37:51'),
(79, 'ACA-26179', 88, 1, 'Cleared', 1.73, 'Cum Laude', 1, '2026-10-20 00:37:52', NULL, NULL, NULL, '2026-10-19 16:37:52', '2026-10-19 16:37:52'),
(80, 'ACA-26180', 89, 1, 'Cleared', 1.82, 'None', 1, '2026-10-20 00:37:52', NULL, NULL, NULL, '2026-10-19 16:37:52', '2026-10-19 16:37:52'),
(81, 'ACA-26181', 90, 1, 'Cleared', 1.65, 'Cum Laude', 1, '2026-10-20 00:37:52', NULL, NULL, NULL, '2026-10-19 16:37:52', '2026-10-19 16:37:52'),
(82, 'ACA-26182', 91, 1, 'Cleared', 1.34, 'Magna Cum Laude', 1, '2026-10-20 00:37:52', NULL, NULL, NULL, '2026-10-19 16:37:52', '2026-10-19 16:37:52'),
(83, 'ACA-26183', 92, 1, 'Cleared', 1.87, 'None', 1, '2026-10-20 00:37:52', NULL, NULL, NULL, '2026-10-19 16:37:52', '2026-10-19 16:37:52'),
(84, 'ACA-26184', 93, 1, 'Cleared', 2.05, 'None', 1, '2026-10-20 00:37:52', NULL, NULL, NULL, '2026-10-19 16:37:52', '2026-10-19 16:37:52'),
(85, 'ACA-26185', 94, 1, 'Cleared', 1.86, 'None', 1, '2026-10-20 00:37:53', NULL, NULL, NULL, '2026-10-19 16:37:53', '2026-10-19 16:37:53'),
(86, 'ACA-26186', 95, 1, 'Cleared', 2.54, 'None', 1, '2026-10-20 00:37:53', NULL, NULL, NULL, '2026-10-19 16:37:53', '2026-10-19 16:37:53'),
(87, 'ACA-26187', 96, 1, 'Cleared', 2.49, 'None', 1, '2026-10-20 00:37:53', NULL, NULL, NULL, '2026-10-19 16:37:53', '2026-10-19 16:37:53'),
(88, 'ACA-26188', 97, 1, 'Cleared', 1.94, 'None', 1, '2026-10-20 00:37:53', NULL, NULL, NULL, '2026-10-19 16:37:53', '2026-10-19 16:37:53'),
(89, 'ACA-26189', 98, 1, 'Cleared', 2.34, 'None', 1, '2026-10-20 00:37:53', NULL, NULL, NULL, '2026-10-19 16:37:53', '2026-10-19 16:37:53'),
(90, 'ACA-26190', 99, 1, 'Cleared', 2.31, 'None', 1, '2026-10-20 00:37:53', NULL, NULL, NULL, '2026-10-19 16:37:53', '2026-10-19 16:37:53'),
(91, 'ACA-26191', 100, 1, 'Cleared', 1.39, 'Magna Cum Laude', 1, '2026-10-20 00:37:54', NULL, NULL, NULL, '2026-10-19 16:37:54', '2026-10-19 16:37:54'),
(92, 'ACA-26192', 101, 1, 'Cleared', 1.72, 'Cum Laude', 1, '2026-10-20 00:37:55', NULL, NULL, NULL, '2026-10-19 16:37:55', '2026-10-19 16:37:55'),
(93, 'ACA-26193', 102, 1, 'Cleared', 2.49, 'None', 1, '2026-10-20 00:37:55', NULL, NULL, NULL, '2026-10-19 16:37:55', '2026-10-19 16:37:55'),
(94, 'ACA-26194', 103, 1, 'Cleared', 2.12, 'None', 1, '2026-10-20 00:37:55', NULL, NULL, NULL, '2026-10-19 16:37:55', '2026-10-19 16:37:55'),
(95, 'ACA-26195', 104, 1, 'Cleared', 1.95, 'None', 1, '2026-10-20 00:37:55', NULL, NULL, NULL, '2026-10-19 16:37:55', '2026-10-19 16:37:55'),
(96, 'ACA-26196', 105, 1, 'Cleared', 1.75, 'Cum Laude', 1, '2026-10-20 00:37:55', NULL, NULL, NULL, '2026-10-19 16:37:55', '2026-10-19 16:37:55'),
(97, 'ACA-26197', 106, 1, 'Cleared', 2.64, 'None', 1, '2026-10-20 00:37:55', NULL, NULL, NULL, '2026-10-19 16:37:55', '2026-10-19 16:37:55'),
(98, 'ACA-26198', 107, 1, 'Cleared', 1.96, 'None', 1, '2026-10-20 00:37:56', NULL, NULL, NULL, '2026-10-19 16:37:56', '2026-10-19 16:37:56'),
(99, 'ACA-26199', 108, 1, 'Cleared', 2.52, 'None', 1, '2026-10-20 00:37:56', NULL, NULL, NULL, '2026-10-19 16:37:56', '2026-10-19 16:37:56'),
(100, 'ACA-26200', 109, 1, 'Cleared', 1.21, 'Magna Cum Laude', 1, '2026-10-20 00:37:56', NULL, NULL, NULL, '2026-10-19 16:37:56', '2026-10-19 16:37:56'),
(101, 'ACA-26201', 110, 1, 'Cleared', 2.20, 'None', 1, '2026-10-20 00:37:56', NULL, NULL, NULL, '2026-10-19 16:37:56', '2026-10-19 16:37:56'),
(102, 'ACA-26202', 111, 1, 'Cleared', 2.56, 'None', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(103, 'ACA-26203', 112, 1, 'Cleared', 1.31, 'Magna Cum Laude', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(104, 'ACA-26204', 113, 1, 'Cleared', 1.91, 'None', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(105, 'ACA-26205', 114, 1, 'Cleared', 1.46, 'Cum Laude', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(106, 'ACA-26206', 115, 1, 'Cleared', 2.02, 'None', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(107, 'ACA-26207', 116, 1, 'Cleared', 1.77, 'None', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(108, 'ACA-26208', 117, 1, 'Cleared', 2.20, 'None', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(109, 'ACA-26209', 118, 1, 'Cleared', 2.11, 'None', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(110, 'ACA-26210', 119, 1, 'Cleared', 1.36, 'Magna Cum Laude', 1, '2026-10-20 00:37:57', NULL, NULL, NULL, '2026-10-19 16:37:57', '2026-10-19 16:37:57'),
(111, 'ACA-26211', 120, 1, 'Cleared', 2.52, 'None', 1, '2026-10-20 00:37:58', NULL, NULL, NULL, '2026-10-19 16:37:58', '2026-10-19 16:37:58'),
(112, 'ACA-26212', 121, 1, 'Cleared', 2.49, 'None', 1, '2026-10-20 00:37:58', NULL, NULL, NULL, '2026-10-19 16:37:58', '2026-10-19 16:37:58'),
(113, 'ACA-26213', 122, 1, 'Cleared', 1.96, 'None', 1, '2026-10-20 00:37:58', NULL, NULL, NULL, '2026-10-19 16:37:58', '2026-10-19 16:37:58'),
(114, 'ACA-26214', 123, 1, 'Cleared', 1.39, 'Magna Cum Laude', 1, '2026-10-20 00:37:58', NULL, NULL, NULL, '2026-10-19 16:37:58', '2026-10-19 16:37:58'),
(115, 'ACA-26215', 124, 1, 'Cleared', 1.72, 'Cum Laude', 1, '2026-10-20 00:37:58', NULL, NULL, NULL, '2026-10-19 16:37:58', '2026-10-19 16:37:58'),
(116, 'ACA-26216', 125, 1, 'Cleared', 1.62, 'Cum Laude', 1, '2026-10-20 00:37:58', NULL, NULL, NULL, '2026-10-19 16:37:58', '2026-10-19 16:37:58'),
(117, 'ACA-26217', 126, 1, 'Cleared', 1.43, 'Magna Cum Laude', 1, '2026-10-20 00:38:00', NULL, NULL, NULL, '2026-10-19 16:38:00', '2026-10-19 16:38:00'),
(118, 'ACA-26218', 127, 1, 'Cleared', 1.25, 'Magna Cum Laude', 1, '2026-10-20 00:38:00', NULL, NULL, NULL, '2026-10-19 16:38:00', '2026-10-19 16:38:00'),
(119, 'ACA-26219', 128, 1, 'Cleared', 1.18, 'Summa Cum Laude', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(120, 'ACA-26220', 129, 1, 'Cleared', 1.53, 'Cum Laude', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(121, 'ACA-26221', 130, 1, 'Cleared', 1.72, 'Cum Laude', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(122, 'ACA-26222', 131, 1, 'Cleared', 2.50, 'None', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(123, 'ACA-26223', 132, 1, 'Cleared', 2.24, 'None', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(124, 'ACA-26224', 133, 1, 'Cleared', 1.97, 'None', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(125, 'ACA-26225', 134, 1, 'Cleared', 1.71, 'Cum Laude', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(126, 'ACA-26226', 135, 1, 'Cleared', 1.22, 'Magna Cum Laude', 1, '2026-10-20 00:38:01', NULL, NULL, NULL, '2026-10-19 16:38:01', '2026-10-19 16:38:01'),
(127, 'ACA-26227', 136, 1, 'Cleared', 2.27, 'None', 1, '2026-10-20 00:38:02', NULL, NULL, NULL, '2026-10-19 16:38:02', '2026-10-19 16:38:02'),
(128, 'ACA-26228', 137, 1, 'Cleared', 2.44, 'None', 1, '2026-10-20 00:38:02', NULL, NULL, NULL, '2026-10-19 16:38:02', '2026-10-19 16:38:02'),
(129, 'ACA-26229', 138, 1, 'Cleared', 2.37, 'None', 1, '2026-10-20 00:38:02', NULL, NULL, NULL, '2026-10-19 16:38:02', '2026-10-19 16:38:02'),
(130, 'ACA-26230', 139, 1, 'Cleared', 2.06, 'None', 1, '2026-10-20 00:38:02', NULL, NULL, NULL, '2026-10-19 16:38:02', '2026-10-19 16:38:02'),
(131, 'ACA-26231', 140, 1, 'Cleared', 2.48, 'None', 1, '2026-10-20 00:38:02', NULL, NULL, NULL, '2026-10-19 16:38:02', '2026-10-19 16:38:02'),
(132, 'ACA-26232', 141, 1, 'Cleared', 2.42, 'None', 1, '2026-10-20 00:38:02', NULL, NULL, NULL, '2026-10-19 16:38:02', '2026-10-19 16:38:02'),
(133, 'ACA-26233', 142, 1, 'Cleared', 2.40, 'None', 1, '2026-10-20 00:38:03', NULL, NULL, NULL, '2026-10-19 16:38:03', '2026-10-19 16:38:03'),
(134, 'ACA-26234', 143, 1, 'Cleared', 1.81, 'None', 1, '2026-10-20 00:38:03', NULL, NULL, NULL, '2026-10-19 16:38:03', '2026-10-19 16:38:03'),
(135, 'ACA-26235', 144, 1, 'Cleared', 1.45, 'Magna Cum Laude', 1, '2026-10-20 00:38:03', NULL, NULL, NULL, '2026-10-19 16:38:03', '2026-10-19 16:38:03'),
(136, 'ACA-26236', 145, 1, 'Cleared', 1.60, 'Cum Laude', 1, '2026-10-20 00:38:03', NULL, NULL, NULL, '2026-10-19 16:38:03', '2026-10-19 16:38:03'),
(137, 'ACA-26237', 146, 1, 'Cleared', 2.01, 'None', 1, '2026-10-20 00:38:03', NULL, NULL, NULL, '2026-10-19 16:38:03', '2026-10-19 16:38:03'),
(138, 'ACA-26238', 147, 1, 'Cleared', 2.36, 'None', 1, '2026-10-20 00:38:03', NULL, NULL, NULL, '2026-10-19 16:38:03', '2026-10-19 16:38:03'),
(139, 'ACA-26239', 148, 1, 'Cleared', 1.31, 'Magna Cum Laude', 1, '2026-10-20 00:38:04', NULL, NULL, NULL, '2026-10-19 16:38:04', '2026-10-19 16:38:04'),
(140, 'ACA-26240', 149, 1, 'Cleared', 2.15, 'None', 1, '2026-10-20 00:38:04', NULL, NULL, NULL, '2026-10-19 16:38:04', '2026-10-19 16:38:04'),
(141, 'ACA-26241', 150, 1, 'Cleared', 1.71, 'Cum Laude', 1, '2026-10-20 00:38:05', NULL, NULL, NULL, '2026-10-19 16:38:05', '2026-10-19 16:38:05'),
(142, 'ACA-26242', 151, 1, 'Cleared', 2.49, 'None', 1, '2026-10-20 00:38:05', NULL, NULL, NULL, '2026-10-19 16:38:05', '2026-10-19 16:38:05'),
(143, 'ACA-26243', 152, 1, 'Cleared', 1.85, 'None', 1, '2026-10-20 00:38:05', NULL, NULL, NULL, '2026-10-19 16:38:05', '2026-10-19 16:38:05'),
(144, 'ACA-26244', 153, 1, 'Cleared', 1.31, 'Magna Cum Laude', 1, '2026-10-20 00:38:05', NULL, NULL, NULL, '2026-10-19 16:38:05', '2026-10-19 16:38:05'),
(145, 'ACA-26245', 154, 1, 'Cleared', 2.31, 'None', 1, '2026-10-20 00:38:06', NULL, NULL, NULL, '2026-10-19 16:38:06', '2026-10-19 16:38:06'),
(146, 'ACA-26246', 155, 1, 'Cleared', 2.49, 'None', 1, '2026-10-20 00:38:06', NULL, NULL, NULL, '2026-10-19 16:38:06', '2026-10-19 16:38:06'),
(147, 'ACA-26247', 156, 1, 'Cleared', 2.33, 'None', 1, '2026-10-20 00:38:06', NULL, NULL, NULL, '2026-10-19 16:38:06', '2026-10-19 16:38:06'),
(148, 'ACA-26248', 157, 1, 'Cleared', 1.93, 'None', 1, '2026-10-20 00:38:06', NULL, NULL, NULL, '2026-10-19 16:38:06', '2026-10-19 16:38:06');

-- --------------------------------------------------------

--
-- Table structure for table `graduation_batches`
--

CREATE TABLE `graduation_batches` (
  `id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `commencement_date` date NOT NULL,
  `bor_resolution_ref` varchar(100) DEFAULT 'BOR-2026-RES-88',
  `college_dean_name` varchar(150) DEFAULT 'Dr. R. Alcantara, PE',
  `vpaa_name` varchar(150) DEFAULT 'Dr. M. S. Santos',
  `status` enum('Active','Endorsed','Closed') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `graduation_batches`
--

INSERT INTO `graduation_batches` (`id`, `term_id`, `label`, `commencement_date`, `bor_resolution_ref`, `college_dean_name`, `vpaa_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Batch 2026', '2027-04-24', 'BOR-2026-RES-88', 'Dr. R. Alcantara, PE', 'Dr. M. S. Santos', 'Active', '2026-10-19 16:36:04', '2026-10-19 16:36:04');

-- --------------------------------------------------------

--
-- Table structure for table `graduation_clearances`
--

CREATE TABLE `graduation_clearances` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `office` varchar(100) NOT NULL,
  `status` enum('Clear','Pending','Hold') NOT NULL DEFAULT 'Pending',
  `verified_by` int(11) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `graduation_clearances`
--

INSERT INTO `graduation_clearances` (`id`, `application_id`, `office`, `status`, `verified_by`, `verified_at`, `remarks`, `created_at`, `updated_at`) VALUES
(21, 1, 'NSTP/ROTC', 'Clear', 1, '2026-10-20 00:52:38', 'ROTC Unit - Serial No. 2020-R-0892', '2026-10-19 16:52:38', '2026-10-19 16:52:38'),
(22, 1, 'Physical Education', 'Clear', 1, '2026-10-20 00:52:38', '8 Units Clear (PE 1-4 Passed)', '2026-10-19 16:52:38', '2026-10-19 16:52:38'),
(23, 1, 'Library', 'Clear', 1, '2026-10-20 00:52:38', 'Zero Accountability - Cleared', '2026-10-19 16:52:38', '2026-10-19 16:52:38'),
(24, 1, 'Cashier & Finance', 'Clear', 1, '2026-10-20 00:52:38', 'Zero Balance / Cleared', '2026-10-19 16:52:38', '2026-10-19 16:52:38'),
(25, 4, 'NSTP/ROTC', 'Clear', 1, '2026-10-20 00:52:38', 'ROTC Unit - Serial No. 2020-R-01892', '2026-10-19 16:52:38', '2026-10-19 16:52:38'),
(26, 4, 'Physical Education', 'Clear', 1, '2026-10-20 00:52:38', '8 Units Clear', '2026-10-19 16:52:38', '2026-10-19 16:52:38'),
(27, 4, 'Library', 'Clear', 1, '2026-10-20 01:13:36', 'Book replaced', '2026-10-19 16:52:39', '2026-10-19 17:13:36'),
(28, 4, 'Cashier & Finance', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Balance', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(29, 2, 'NSTP/ROTC', 'Clear', 1, '2026-10-20 00:52:39', 'ROTC Serial No. Verified', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(30, 2, 'Physical Education', 'Clear', 1, '2026-10-20 00:52:39', '8 Units Clear', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(31, 2, 'Library', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Accountability', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(32, 2, 'Cashier & Finance', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Balance', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(33, 3, 'NSTP/ROTC', 'Clear', 1, '2026-10-20 00:52:39', 'ROTC Serial No. Verified', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(34, 3, 'Physical Education', 'Clear', 1, '2026-10-20 00:52:39', '8 Units Clear', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(35, 3, 'Library', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Accountability', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(36, 3, 'Cashier & Finance', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Balance', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(37, 5, 'NSTP/ROTC', 'Clear', 1, '2026-10-20 00:52:39', 'ROTC Serial No. Verified', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(38, 5, 'Physical Education', 'Clear', 1, '2026-10-20 00:52:39', '8 Units Clear', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(39, 5, 'Library', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Accountability', '2026-10-19 16:52:39', '2026-10-19 16:52:39'),
(40, 5, 'Cashier & Finance', 'Clear', 1, '2026-10-20 00:52:39', 'Zero Balance', '2026-10-19 16:52:39', '2026-10-19 16:52:39');

-- --------------------------------------------------------

--
-- Table structure for table `graduation_status_history`
--

CREATE TABLE `graduation_status_history` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `from_status` varchar(50) NOT NULL,
  `to_status` varchar(50) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `graduation_status_history`
--

INSERT INTO `graduation_status_history` (`id`, `application_id`, `from_status`, `to_status`, `remarks`, `changed_by`, `changed_at`) VALUES
(1, 1, 'Ready for Conferment', 'Ready for Conferment', 'Cleared and recommended for academic degree conferment.', 1, '2026-10-19 16:58:43'),
(2, 1, 'Ready for Conferment', 'Completed', 'Officially conferred degree and transitioned to Graduated Alumnus status.', 1, '2026-10-19 18:07:20'),
(3, 2, 'Ready for Conferment', 'Endorsed', 'Endorsed under BOR Commencement Docket.', 1, '2026-10-19 18:11:41'),
(4, 3, 'Ready for Conferment', 'Endorsed', 'Endorsed under BOR Commencement Docket.', 1, '2026-10-19 18:11:41');

-- --------------------------------------------------------

--
-- Table structure for table `guardians`
--

CREATE TABLE `guardians` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `relationship` varchar(50) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `contact_number` varchar(30) NOT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `guardians`
--

INSERT INTO `guardians` (`id`, `user_id`, `relationship`, `full_name`, `contact_number`, `occupation`, `address`, `created_at`, `updated_at`) VALUES
(6, 2, 'Father', 'Manuel S. Pearce', '+63 917 554 2109', 'Civil Engineer', 'Purok 4, San Jose Road, Tagum City', '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(7, 5, 'Mother', 'Elena R. Reyes', '+63 920 887 6512', 'Secondary School Teacher', 'Zone 3, Magsaysay St., Digos City', '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(8, 6, 'Mother', 'Corazon C. Flores', '+63 918 229 8811', 'Registered Nurse', 'Purok Mangga, Sto. Niño, Panabo City', '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(9, 7, 'Father', 'Theodore G. Lim', '+63 917 889 1120', 'Contractor', '14 Palm Drive, Matina, Davao City', '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(10, 8, 'Mother', 'Bernadette B. Ramos', '+63 919 663 0019', 'Public Health Worker', 'Purok 2, Central, Mati City', '2026-10-19 12:02:42', '2026-10-19 12:02:42');

-- --------------------------------------------------------

--
-- Table structure for table `loa_clearances`
--

CREATE TABLE `loa_clearances` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `step_no` int(11) NOT NULL,
  `office` enum('Health Services Clinic','OSAS Guidance & Counseling','College Dean & Department Chair','Registrar Reactivation') NOT NULL,
  `status` enum('Pending','Verified') NOT NULL DEFAULT 'Pending',
  `verified_by_name` varchar(150) DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loa_clearances`
--

INSERT INTO `loa_clearances` (`id`, `request_id`, `step_no`, `office`, `status`, `verified_by_name`, `verified_at`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Health Services Clinic', 'Verified', 'Dr. M. Cruz, MD (University Physician)', '2026-10-18 09:24:00', 'Physician Medical Clearance verified and filed • Fit to Resume Studies', '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(2, 1, 2, 'OSAS Guidance & Counseling', 'Verified', 'Prof. E. Santos (OSAS Director)', '2026-10-19 15:15:00', 'Re-orientation interview conducted • Exit & Re-entry documentation sealed', '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(3, 1, 3, 'College Dean & Department Chair', 'Verified', 'Dr. R. Alcantara (Dean CBA)', '2026-10-19 16:40:00', 'Curriculum alignment preserved • Course block assignments unlocked', '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(4, 1, 4, 'Registrar Reactivation', 'Verified', 'Registrar Admin', '2026-10-19 17:00:00', 'Reactivate Student Information System (SIS) access and issue Certificate of Re-admission', '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(5, 2, 1, 'Health Services Clinic', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(6, 2, 2, 'OSAS Guidance & Counseling', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(7, 2, 3, 'College Dean & Department Chair', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(8, 2, 4, 'Registrar Reactivation', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(9, 3, 1, 'Health Services Clinic', 'Verified', 'Dr. M. Cruz, MD', '2026-10-18 10:00:00', 'Medical physical evaluation cleared', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(10, 3, 2, 'OSAS Guidance & Counseling', 'Verified', 'OSAS Counselor J. Reyes', '2026-10-18 14:30:00', 'Readmission interview completed', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(11, 3, 3, 'College Dean & Department Chair', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(12, 3, 4, 'Registrar Reactivation', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(13, 4, 1, 'Health Services Clinic', 'Verified', 'Dr. M. Cruz, MD', '2026-10-11 10:00:00', 'Medical record noted', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(14, 4, 2, 'OSAS Guidance & Counseling', 'Verified', 'OSAS Director', '2026-10-11 14:00:00', 'Endorsement approved', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(15, 4, 3, 'College Dean & Department Chair', 'Verified', 'Dean CAS', '2026-10-12 09:30:00', 'Academic clearance signed', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(16, 4, 4, 'Registrar Reactivation', 'Pending', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(17, 5, 1, 'Health Services Clinic', 'Verified', 'Registrar Records Staff', '2025-08-19 16:00:00', 'Prior archival clearance validated', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(18, 5, 2, 'OSAS Guidance & Counseling', 'Verified', 'Registrar Records Staff', '2025-08-19 16:00:00', 'Prior archival clearance validated', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(19, 5, 3, 'College Dean & Department Chair', 'Verified', 'Registrar Records Staff', '2025-08-19 16:00:00', 'Prior archival clearance validated', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(20, 5, 4, 'Registrar Reactivation', 'Verified', 'Registrar Records Staff', '2025-08-19 16:00:00', 'Prior archival clearance validated', '2026-10-19 18:28:55', '2026-10-19 18:28:55');

-- --------------------------------------------------------

--
-- Table structure for table `loa_documents`
--

CREATE TABLE `loa_documents` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `doc_type` varchar(100) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loa_documents`
--

INSERT INTO `loa_documents` (`id`, `request_id`, `doc_type`, `file_name`, `file_path`, `uploaded_at`) VALUES
(1, 1, 'Form 104 Returnee Slip', 'Form_104_Returnee_Slip_ACA-26043.pdf', 'uploads/loa/Form_104_Returnee_Slip_ACA-26043.pdf', '2026-10-19 17:00:00'),
(2, 1, 'Certificate of Eligibility', 'Cert_Eligibility_ACA-26043.pdf', 'uploads/loa/Cert_Eligibility_ACA-26043.pdf', '2026-10-19 17:00:00'),
(3, 1, 'Medical Clearance', 'Health_Clearance_Medical_Fit.pdf', 'uploads/loa/Health_Clearance_Medical_Fit.pdf', '2026-10-18 09:24:00'),
(4, 1, 'OSAS Clearance', 'OSAS_Exit_Reentry_Form.pdf', 'uploads/loa/OSAS_Exit_Reentry_Form.pdf', '2026-10-19 15:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `loa_requests`
--

CREATE TABLE `loa_requests` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `student_id` int(11) NOT NULL,
  `type` enum('Leave','Readmission') NOT NULL,
  `leave_start_term_id` int(11) DEFAULT NULL,
  `leave_end_term_id` int(11) DEFAULT NULL,
  `reason` text NOT NULL,
  `status` enum('Pending','Awaiting Dean Endorsement','Approved','Declined','Completed','Archived') NOT NULL DEFAULT 'Pending',
  `is_sealed` tinyint(1) NOT NULL DEFAULT 0,
  `submitted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `decided_by` int(11) DEFAULT NULL,
  `decided_at` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loa_requests`
--

INSERT INTO `loa_requests` (`id`, `reference_no`, `student_id`, `type`, `leave_start_term_id`, `leave_end_term_id`, `reason`, `status`, `is_sealed`, `submitted_at`, `decided_by`, `decided_at`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 'ACA-26043', 8, 'Readmission', 3, 3, 'Readmission after one semester LOA (Medical Leave recovery completed)', 'Completed', 0, '2026-10-15 08:30:00', 1, '2026-10-19 17:00:00', 'Institutional clearance sequence fully satisfied and validated.', '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(2, 'ACA-26044', 5, 'Leave', 1, 4, 'Employment apprenticeship commitment and family medical support in North Cotabato', 'Pending', 0, '2026-10-18 11:15:00', NULL, NULL, NULL, '2026-10-19 18:28:54', '2026-10-19 18:28:54'),
(3, 'ACA-26045', 2, 'Readmission', 3, 1, 'Returnee after 2 semesters prolonged absence due to financial rehabilitation and industry work', 'Awaiting Dean Endorsement', 0, '2026-10-17 14:00:00', NULL, NULL, NULL, '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(4, 'ACA-26046', 6, 'Leave', 1, 4, 'Inter-university developmental psychology research internship at UP Diliman', 'Approved', 0, '2026-10-10 09:00:00', 1, '2026-10-12 11:30:00', 'Official Leave of Absence approved by College Dean and University Registrar.', '2026-10-19 18:28:55', '2026-10-19 18:28:55'),
(5, 'ACA-25019', 7, 'Readmission', 3, 3, 'Prior semester leave completed, clearances satisfied and archived', 'Completed', 1, '2025-08-10 09:00:00', 1, '2025-08-20 14:00:00', 'Ledger entry officially sealed and archived.', '2026-10-19 18:28:55', '2026-10-19 18:28:55');

-- --------------------------------------------------------

--
-- Table structure for table `loa_status_history`
--

CREATE TABLE `loa_status_history` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loa_status_history`
--

INSERT INTO `loa_status_history` (`id`, `request_id`, `from_status`, `to_status`, `remarks`, `changed_by`, `changed_at`) VALUES
(1, 1, NULL, 'Pending', 'Initial readmission dossier filed by student', 8, '2026-10-15 08:30:00'),
(2, 1, 'Pending', 'Awaiting Dean Endorsement', 'Health and OSAS clearances verified', 1, '2026-10-19 15:20:00'),
(3, 1, 'Awaiting Dean Endorsement', 'Approved', 'Dean endorsement signed', 1, '2026-10-19 16:45:00'),
(4, 1, 'Approved', 'Completed', 'SIS account re-activated and Form 104 issued', 1, '2026-10-19 17:00:00'),
(5, 2, NULL, 'Pending', 'Official Leave of Absence application submitted online', 5, '2026-10-18 11:15:00'),
(6, 3, NULL, 'Pending', 'Readmission filed', 2, '2026-10-17 14:00:00'),
(7, 3, 'Pending', 'Awaiting Dean Endorsement', 'Clinic and OSAS clearances endorsed', 1, '2026-10-18 15:00:00'),
(8, 4, NULL, 'Pending', 'Leave request submitted', 6, '2026-10-10 09:00:00'),
(9, 4, 'Pending', 'Approved', 'Leave request approved, status set to On Leave', 1, '2026-10-12 11:30:00'),
(10, 5, 'Approved', 'Completed', 'Readmission completed', 1, '2025-08-20 14:00:00'),
(11, 5, 'Completed', 'Archived', 'Finalized & Sealed Ledger Entry', 1, '2025-08-20 14:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` int(11) NOT NULL,
  `college_id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `years` tinyint(4) NOT NULL DEFAULT 4,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`id`, `college_id`, `code`, `name`, `years`, `created_at`) VALUES
(1, 1, 'BSCS', 'Bachelor of Science in Computer Science', 4, '2026-10-19 12:01:41'),
(2, 1, 'BSIT', 'Bachelor of Science in Information Technology', 4, '2026-10-19 12:01:42'),
(3, 1, 'BSIS', 'Bachelor of Science in Information Systems', 4, '2026-10-19 12:01:42'),
(4, 2, 'BSPSY', 'Bachelor of Science in Psychology', 4, '2026-10-19 12:01:42'),
(5, 2, 'BACOMM', 'Bachelor of Arts in Communication', 4, '2026-10-19 12:01:42'),
(6, 2, 'BSBIO', 'Bachelor of Science in Biology', 4, '2026-10-19 12:01:42'),
(7, 3, 'BSCE', 'Bachelor of Science in Civil Engineering', 4, '2026-10-19 12:01:42'),
(8, 3, 'BSEE', 'Bachelor of Science in Electrical Engineering', 4, '2026-10-19 12:01:42'),
(9, 3, 'BSME', 'Bachelor of Science in Mechanical Engineering', 4, '2026-10-19 12:01:42'),
(10, 4, 'BSED', 'Bachelor of Secondary Education', 4, '2026-10-19 12:01:42'),
(11, 4, 'BEED', 'Bachelor of Elementary Education', 4, '2026-10-19 12:01:42'),
(12, 5, 'BSBA', 'Bachelor of Science in Business Administration', 4, '2026-10-19 12:01:42'),
(37, 5, 'BSENTREP', 'Bachelor of Science in Entrepreneurship', 4, '2026-10-19 18:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `record_corrections`
--

CREATE TABLE `record_corrections` (
  `id` int(11) NOT NULL,
  `tracking_code` varchar(30) NOT NULL,
  `student_id` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `current_value` varchar(255) NOT NULL,
  `proposed_value` varchar(255) NOT NULL,
  `contact_number` varchar(30) NOT NULL,
  `reason` text NOT NULL,
  `supporting_documents` text DEFAULT NULL,
  `status` enum('Pending Review','Under Review','Needs More Info','Approved','Rejected') NOT NULL DEFAULT 'Pending Review',
  `registrar_remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `record_corrections`
--

INSERT INTO `record_corrections` (`id`, `tracking_code`, `student_id`, `category`, `current_value`, `proposed_value`, `contact_number`, `reason`, `supporting_documents`, `status`, `registrar_remarks`, `created_at`, `updated_at`) VALUES
(1, 'CR-2026-000842', 2, 'name', 'JOSHUA PEARCE', 'JOSHUA MANUEL PEARCE', '+63 947 882 1094', 'My official Philippine Statistics Authority (PSA) Certificate of Live Birth indicates my complete middle name as MANUEL instead of single initial M.', '[{\"name\":\"PSA_Birth_Certificate_JoshuaPearce.pdf\",\"size\":2415919,\"type\":\"application\\/pdf\"}]', 'Under Review', 'Awaiting secondary ID copy from student for final validation.', '2026-10-13 10:24:03', '2026-10-17 16:24:03'),
(2, 'CR-2025-000109', 2, 'curriculum', 'BS Computer Science (Curriculum Year 2020)', 'BS Computer Science (Curriculum Year 2021)', '+63 947 882 1094', 'Curriculum tagging alignment per College of Computing Dean memorandum regarding 2021 curriculum catalog shift.', NULL, 'Approved', 'Curriculum tagging verified with College Dean. SIS ledger updated successfully.', '2026-08-18 10:24:03', '2026-10-17 16:24:03'),
(3, 'CR-2026-696041', 2, 'birthdate', 'May 14, 2003', 'May 18, 2003', '+63 947 882 1094', 'Discrepancy in official birth certificate records authenticated by PSA registry.', '[{\"name\":\"PSA_Birth_Cert.pdf\",\"size\":1048576,\"type\":\"application\\/pdf\"}]', 'Under Review', 'PSA document currently undergoing verification with central records.', '2026-10-17 16:25:44', '2026-10-17 16:26:01'),
(4, 'CR-2026-757435', 2, 'birthdate', 'MAY 14, 2003', 'MAY 18, 2003', '+63 947 882 1094', 'Discrepancy in official PSA birth certificate records registered in Davao City civil registrar.', NULL, 'Pending Review', NULL, '2026-10-17 16:36:31', '2026-10-17 16:36:31');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `tracking_code` varchar(20) NOT NULL,
  `student_id` int(11) NOT NULL,
  `fulfillment_method` enum('pickup','delivery') NOT NULL,
  `payment_method` enum('cash','cashier','online') NOT NULL,
  `total_fee` decimal(10,2) NOT NULL,
  `status` enum('Pending Review','Processing','Ready for Pickup','Completed','Declined') NOT NULL DEFAULT 'Pending Review',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `tracking_code`, `student_id`, `fulfillment_method`, `payment_method`, `total_fee`, `status`, `created_at`, `updated_at`) VALUES
(1, 'REG-260914', 2, 'pickup', 'cash', 150.00, 'Completed', '2026-10-06 13:36:16', '2026-10-06 14:31:28'),
(2, 'REG-260903', 2, 'pickup', 'cashier', 200.00, 'Declined', '2026-10-06 13:36:16', '2026-10-06 13:43:55'),
(3, 'COR-260827', 2, 'delivery', 'online', 50.00, 'Completed', '2026-10-06 13:36:16', '2026-10-06 13:44:06'),
(4, 'DOC-2610062671', 1, 'pickup', 'cashier', 150.00, 'Declined', '2026-10-06 14:23:26', '2026-10-06 14:55:52'),
(5, 'DOC-2610065712', 2, 'pickup', 'cash', 50.00, 'Declined', '2026-10-06 14:30:10', '2026-10-06 14:31:05'),
(6, 'DOC-2610065677', 2, 'pickup', 'cash', 150.00, 'Declined', '2026-10-06 14:43:57', '2026-10-06 14:55:50'),
(7, 'DOC-2610062132', 2, 'pickup', '', 150.00, 'Declined', '2026-10-06 14:44:47', '2026-10-06 14:55:49'),
(8, 'DOC-2610067327', 2, 'pickup', 'online', 50.00, 'Declined', '2026-10-06 17:11:44', '2026-10-17 14:23:42'),
(9, 'DOC-2610178298', 2, 'pickup', 'online', 50.00, 'Pending Review', '2026-10-17 14:24:33', '2026-10-17 14:24:33'),
(10, 'DOC-2610171184', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:03:29', '2026-10-17 16:03:29'),
(11, 'DOC-2610171534', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:03:42', '2026-10-17 16:03:42'),
(12, 'DOC-2610172881', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:03:55', '2026-10-17 16:03:55'),
(13, 'DOC-2610173685', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:04:09', '2026-10-17 16:04:09'),
(14, 'DOC-2610179393', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:04:26', '2026-10-17 16:04:26'),
(15, 'DOC-2610178026', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:04:42', '2026-10-17 16:04:42'),
(16, 'DOC-2610178376', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:06:37', '2026-10-17 16:06:37'),
(17, 'DOC-2610176666', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:06:54', '2026-10-17 16:06:54'),
(18, 'DOC-2610172993', 1, 'pickup', 'online', 150.00, 'Completed', '2026-10-17 16:07:11', '2026-10-17 16:21:27'),
(19, 'DOC-2610172207', 1, 'pickup', 'online', 150.00, 'Declined', '2026-10-17 16:07:29', '2026-10-17 16:21:20'),
(20, 'DOC-2610175525', 1, 'pickup', 'online', 150.00, 'Processing', '2026-10-17 16:07:43', '2026-10-17 16:21:17'),
(21, 'DOC-2610174997', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:07:57', '2026-10-17 16:07:57'),
(22, 'DOC-2610185996', 2, 'delivery', 'online', 150.00, 'Pending Review', '2026-10-18 04:39:13', '2026-10-18 04:39:13'),
(23, 'DOC-2610181018', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 04:54:49', '2026-10-18 04:54:49'),
(24, 'DOC-2610187216', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 05:06:24', '2026-10-18 05:06:24'),
(25, 'DOC-2610189098', 2, 'delivery', 'online', 620.00, 'Pending Review', '2026-10-18 05:06:24', '2026-10-18 05:06:24'),
(26, 'DOC-2610188912', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 05:11:35', '2026-10-18 05:11:35'),
(27, 'DOC-2610186203', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 05:12:51', '2026-10-18 05:12:51'),
(28, 'DOC-2610183980', 2, 'pickup', 'online', 80.00, 'Pending Review', '2026-10-18 05:19:31', '2026-10-18 05:19:31'),
(29, 'DOC-2610186065', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 12:55:15', '2026-10-18 12:55:15'),
(30, 'DOC-2610184125', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 12:56:58', '2026-10-18 12:56:58'),
(31, 'DOC-2610184774', 2, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-18 13:03:10', '2026-10-18 13:03:10'),
(32, 'DOC-2610188198', 2, 'pickup', 'online', 310.00, 'Pending Review', '2026-10-18 13:09:54', '2026-10-18 13:09:54'),
(33, 'DOC-2610184505', 2, 'pickup', 'online', 150.00, 'Declined', '2026-10-18 13:15:36', '2026-10-19 16:55:38'),
(34, 'DOC-2610187589', 2, 'pickup', 'online', 430.00, 'Processing', '2026-10-18 13:24:21', '2026-10-19 16:55:46'),
(35, 'DOC-2610184847', 2, 'pickup', 'online', 80.00, 'Pending Review', '2026-10-18 13:34:52', '2026-10-18 13:34:52'),
(36, 'DOC-2610189901', 2, 'pickup', 'online', 350.00, 'Pending Review', '2026-10-18 13:45:35', '2026-10-18 13:45:35'),
(37, 'DOC-2610186899', 2, 'pickup', 'online', 150.00, 'Declined', '2026-10-18 13:53:14', '2026-10-19 16:55:21'),
(38, 'DOC-2610181809', 2, 'delivery', 'online', 270.00, 'Pending Review', '2026-10-18 14:11:21', '2026-10-18 14:11:21'),
(39, 'DOC-2609011020', 2, 'pickup', 'online', 150.00, 'Completed', '2026-09-01 02:20:00', '2026-09-01 02:20:00'),
(40, 'DOC-2609051430', 2, 'pickup', 'cash', 80.00, 'Completed', '2026-09-05 06:30:00', '2026-09-05 06:30:00'),
(41, 'DOC-2609120915', 2, 'delivery', 'online', 50.00, 'Completed', '2026-09-12 01:15:00', '2026-09-12 01:15:00'),
(42, 'DOC-2609181140', 2, 'pickup', 'cashier', 100.00, 'Completed', '2026-09-18 03:40:00', '2026-09-18 03:40:00'),
(43, 'DOC-2609251600', 2, 'pickup', 'online', 80.00, 'Ready for Pickup', '2026-09-25 08:00:00', '2026-09-25 08:00:00'),
(44, 'DOC-2610020845', 2, 'pickup', 'cash', 80.00, 'Processing', '2026-10-02 00:45:00', '2026-10-02 00:45:00'),
(45, 'DOC-2610071320', 2, 'delivery', 'online', 150.00, 'Processing', '2026-10-07 05:20:00', '2026-10-07 05:20:00'),
(46, 'DOC-2610111510', 2, 'pickup', 'online', 50.00, 'Ready for Pickup', '2026-10-11 07:10:00', '2026-10-11 07:10:00'),
(47, 'DOC-2610141005', 2, 'pickup', 'cash', 100.00, 'Pending Review', '2026-10-14 02:05:00', '2026-10-14 02:05:00');

-- --------------------------------------------------------

--
-- Table structure for table `request_items`
--

CREATE TABLE `request_items` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `copies` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request_items`
--

INSERT INTO `request_items` (`id`, `request_id`, `document_id`, `copies`) VALUES
(1, 1, 1, 1),
(2, 2, 7, 1),
(3, 3, 3, 1),
(4, 4, 1, 1),
(5, 5, 3, 1),
(6, 6, 1, 1),
(7, 7, 1, 1),
(8, 8, 5, 1),
(9, 9, 3, 1),
(10, 10, 1, 1),
(11, 11, 1, 1),
(12, 12, 1, 1),
(13, 13, 1, 1),
(14, 14, 1, 1),
(15, 15, 1, 1),
(16, 16, 1, 1),
(17, 17, 1, 1),
(18, 18, 1, 1),
(19, 19, 1, 1),
(20, 20, 1, 1),
(21, 21, 1, 1),
(22, 22, 1, 1),
(23, 23, 1, 1),
(24, 24, 1, 1),
(25, 25, 6, 1),
(26, 25, 7, 1),
(27, 26, 1, 1),
(28, 27, 6, 1),
(29, 28, 2, 1),
(30, 29, 1, 1),
(31, 30, 1, 1),
(32, 31, 1, 1),
(33, 32, 1, 1),
(34, 32, 3, 2),
(35, 33, 1, 1),
(36, 34, 3, 1),
(37, 34, 7, 1),
(38, 35, 2, 1),
(39, 36, 7, 1),
(40, 37, 6, 1),
(41, 38, 6, 1),
(42, 39, 1, 1),
(43, 40, 3, 1),
(44, 41, 4, 1),
(45, 42, 5, 1),
(46, 43, 2, 1),
(47, 44, 3, 1),
(48, 45, 1, 1),
(49, 46, 4, 1),
(50, 47, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shifting_clearances`
--

CREATE TABLE `shifting_clearances` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `step_number` int(11) NOT NULL DEFAULT 1,
  `role` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL,
  `status` enum('Pending','Endorsed','Accepted') NOT NULL DEFAULT 'Pending',
  `remarks` text DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifting_clearances`
--

INSERT INTO `shifting_clearances` (`id`, `request_id`, `step_number`, `role`, `name`, `status`, `remarks`, `signed_at`, `created_at`) VALUES
(1, 1, 1, 'Dean of origin college', 'Dr. Arlene M. Ramos', 'Endorsed', 'Endorsed by CAS Dean', '2026-10-15 14:20:00', '2026-10-19 15:37:09'),
(2, 1, 2, 'Head of destination department', 'Prof. Carlos E. Tan', 'Accepted', 'Accepted Slot (Quota: 45/50)', '2026-10-16 10:15:00', '2026-10-19 15:37:09'),
(3, 1, 3, 'Registrar Admin Evaluator', 'Registrar Admin Evaluator', 'Accepted', 'Final Registrar Authorization Signed and Committed to SIS', '2026-10-20 00:23:46', '2026-10-19 15:37:09'),
(4, 1, 4, 'Office of Student Affairs', 'Dr. Josefa Garcia', 'Accepted', 'Good Behavioral Standing', '2026-10-16 16:30:00', '2026-10-19 15:37:09'),
(5, 2, 1, 'Head of destination department', 'Engr. Roberto M. Santos', 'Pending', 'Awaiting Syllabi Verification', NULL, '2026-10-19 15:37:10'),
(6, 2, 2, 'Dean of College of Engineering', 'Dr. Eduardo Gomez', 'Pending', 'Awaiting Department Recommendation', NULL, '2026-10-19 15:37:10'),
(7, 2, 3, 'Registrar Admin Evaluator', 'Registrar Admin Evaluator', 'Pending', 'Pending Pre-requisite Audit', NULL, '2026-10-19 15:37:10'),
(8, 2, 4, 'Admissions Office', 'Atty. Gina Morales', 'Endorsed', 'Transferee Entrance Credentials Complete', '2026-10-17 09:00:00', '2026-10-19 15:37:10'),
(9, 3, 1, 'Dean of College of Education', 'Dr. Corazon Bautista', 'Endorsed', 'Clearance Endorsed', '2026-10-18 10:00:00', '2026-10-19 15:37:10'),
(10, 3, 2, 'Head of Elementary Education', 'Prof. Liza Cruz', 'Accepted', 'Accepted Slot', '2026-10-18 14:00:00', '2026-10-19 15:37:11'),
(11, 3, 3, 'Registrar Admin Evaluator', 'Registrar Admin Evaluator', 'Endorsed', 'Curriculum Audit Satisfied', '2026-10-19 09:30:00', '2026-10-19 15:37:11');

-- --------------------------------------------------------

--
-- Table structure for table `shifting_documents`
--

CREATE TABLE `shifting_documents` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int(11) NOT NULL DEFAULT 0,
  `mime_type` varchar(100) NOT NULL DEFAULT 'application/pdf',
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifting_documents`
--

INSERT INTO `shifting_documents` (`id`, `request_id`, `file_name`, `file_path`, `file_size`, `mime_type`, `uploaded_by`, `created_at`) VALUES
(1, 1, 'Official_Transcript_Record_2022-00612.pdf', 'storage/shifting_docs/Official_Transcript_Record_2022-00612.pdf', 2516582, 'application/pdf', 6, '2026-10-19 15:37:10'),
(2, 1, 'Formal_Shifting_Intent_Letter.pdf', 'storage/shifting_docs/Formal_Shifting_Intent_Letter.pdf', 1153433, 'application/pdf', 6, '2026-10-19 15:37:10'),
(3, 2, 'MSU_IIT_Official_Transcript_Lim.pdf', 'storage/shifting_docs/MSU_IIT_Official_Transcript_Lim.pdf', 3145728, 'application/pdf', 6, '2026-10-19 15:37:10');

-- --------------------------------------------------------

--
-- Table structure for table `shifting_requests`
--

CREATE TABLE `shifting_requests` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `student_id` int(11) NOT NULL,
  `type` enum('Internal Shift','External Transfer') NOT NULL DEFAULT 'Internal Shift',
  `from_program_id` int(11) DEFAULT NULL,
  `from_school` varchar(255) DEFAULT NULL,
  `from_program_text` varchar(255) DEFAULT NULL,
  `to_program_id` int(11) NOT NULL,
  `reason` text NOT NULL,
  `status` enum('Pending Department Review','Processing','Approved','Declined','Completed') NOT NULL DEFAULT 'Pending Department Review',
  `current_step` int(11) NOT NULL DEFAULT 1,
  `total_steps` int(11) NOT NULL DEFAULT 4,
  `remarks_internal` text DEFAULT NULL,
  `decided_by` int(11) DEFAULT NULL,
  `decided_at` datetime DEFAULT NULL,
  `submitted_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifting_requests`
--

INSERT INTO `shifting_requests` (`id`, `reference_no`, `student_id`, `type`, `from_program_id`, `from_school`, `from_program_text`, `to_program_id`, `reason`, `status`, `current_step`, `total_steps`, `remarks_internal`, `decided_by`, `decided_at`, `submitted_at`, `created_at`, `updated_at`) VALUES
(1, 'ACA-26068', 6, 'Internal Shift', 5, NULL, NULL, 4, 'Medical & Clinical Path Alignment', 'Completed', 4, 4, 'CAS Board endorsed. Final evaluation by Registrar in progress.', 1, '2026-10-20 00:23:46', '2026-10-14 11:20:00', '2026-10-19 15:37:09', '2026-10-19 16:23:46'),
(2, 'TRA-26015', 7, 'External Transfer', NULL, 'Mindanao State University - IIT', 'BS Computer Engineering', 7, 'Family relocation to Davao City and civil infrastructure concentration', 'Pending Department Review', 1, 4, 'Incoming transferee from MSU-IIT. Awaiting syllabus equivalency verification.', NULL, NULL, '2026-10-14 11:20:00', '2026-10-19 15:37:10', '2026-10-19 15:37:10'),
(3, 'ACA-26075', 8, 'Internal Shift', 10, NULL, NULL, 11, 'Early childhood education focus', 'Approved', 4, 4, 'All clearances signed. Ready for final SIS ledger commitment.', NULL, NULL, '2026-10-14 11:20:00', '2026-10-19 15:37:10', '2026-10-19 15:37:10');

-- --------------------------------------------------------

--
-- Table structure for table `shifting_status_history`
--

CREATE TABLE `shifting_status_history` (
  `id` int(11) NOT NULL,
  `request_id` int(11) NOT NULL,
  `from_status` varchar(100) NOT NULL,
  `to_status` varchar(100) NOT NULL,
  `remarks` text DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifting_status_history`
--

INSERT INTO `shifting_status_history` (`id`, `request_id`, `from_status`, `to_status`, `remarks`, `changed_by`, `changed_at`) VALUES
(1, 1, 'Pending Department Review', 'Processing', 'Endorsed by CAS Dean and Psychology Dept Chair. Units evaluated.', 1, '2026-10-19 15:37:10'),
(2, 1, 'Processing', 'Completed', 'Program shift executed and finalized in Student Information System (SIS).', 1, '2026-10-19 16:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `staff_profiles`
--

CREATE TABLE `staff_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `employee_no` varchar(30) NOT NULL,
  `position` varchar(100) NOT NULL DEFAULT 'Head Evaluator',
  `office` varchar(100) NOT NULL DEFAULT 'Office of the University Registrar',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `staff_profiles`
--

INSERT INTO `staff_profiles` (`id`, `user_id`, `employee_no`, `position`, `office`, `updated_at`) VALUES
(1, 1, 'REG-ADMIN-04', 'Head Evaluator', 'Office of the University Registrar, Obrero Main Campus', '2026-10-19 12:02:11');

-- --------------------------------------------------------

--
-- Table structure for table `student_credits`
--

CREATE TABLE `student_credits` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_code` varchar(50) NOT NULL,
  `subject_title` varchar(200) NOT NULL,
  `units` decimal(4,1) NOT NULL,
  `grade` decimal(3,2) NOT NULL,
  `term_id` int(11) NOT NULL,
  `category` enum('Major','General Education','Practicum','Electives') NOT NULL,
  `status` enum('PASSED','FAILED','INCOMPLETE','DROPPED') NOT NULL DEFAULT 'PASSED',
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_credits`
--

INSERT INTO `student_credits` (`id`, `student_id`, `subject_id`, `subject_code`, `subject_title`, `units`, `grade`, `term_id`, `category`, `status`, `remarks`, `created_at`) VALUES
(60, 5, NULL, 'CE 101', 'Civil Engineering Orientation', 2.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(61, 5, NULL, 'CE 211', 'Statics of Rigid Bodies', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(62, 5, NULL, 'CE 212', 'Dynamics of Rigid Bodies', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(63, 5, NULL, 'CE 311', 'Structural Theory', 4.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(64, 5, NULL, 'CE 312', 'Reinforced Concrete Design', 4.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(65, 5, NULL, 'CE 321', 'Hydraulics & Water Resources', 4.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(66, 5, NULL, 'CE 322', 'Geotechnical Engineering', 4.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(67, 5, NULL, 'CE 411', 'Principles of Transportation Engineering', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(68, 5, NULL, 'CE 412', 'Construction Materials & Testing', 3.0, 1.00, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(69, 5, NULL, 'CE 413', 'Structural Steel Design', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(70, 5, NULL, 'CE 421', 'Civil Engineering Project I (Capstone)', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed: 1.25', '2026-10-19 16:52:34'),
(71, 5, NULL, 'CE 422', 'Civil Engineering Project II (Capstone)', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed: 1.25', '2026-10-19 16:52:34'),
(72, 5, NULL, 'CE 423', 'Quantity Surveying & Cost Estimation', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(73, 5, NULL, 'CE 424', 'CE Laws, Ethics & Contracts', 2.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(74, 5, NULL, 'ENGR 101', 'Calculus I & II Sequence', 8.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(75, 5, NULL, 'ENGR 102', 'Differential Equations', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(76, 5, NULL, 'ENGR 103', 'Engineering Economy', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(77, 5, NULL, 'ENGR 104', 'Engineering Utilities I & II', 6.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(78, 5, NULL, 'ENGR 105', 'Computer-Aided Drafting (CAD)', 2.0, 1.00, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(79, 5, NULL, 'ENGR 106', 'Basic Electrical & Electronics', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:34'),
(80, 5, NULL, 'ENGR 107', 'Materials Science & Nanotechnology', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:35'),
(81, 5, NULL, 'ENGR 108', 'Environmental Engineering', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:35'),
(82, 5, NULL, 'ENGR 109', 'Safety & Occupational Health', 2.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:35'),
(83, 5, NULL, 'ENGR 110', 'Surveying (Higher Surveying & Lab)', 5.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:35'),
(84, 5, NULL, 'ENGR 111', 'Numerical Methods', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:35'),
(85, 5, NULL, 'CE 425', 'Geotechnical Engineering Lab & Practice', 3.0, 1.25, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:35'),
(86, 5, NULL, 'GE 101', 'Understanding the Self', 3.0, 1.25, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:35'),
(87, 5, NULL, 'GE 102', 'Readings in Philippine History', 3.0, 1.00, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:35'),
(88, 5, NULL, 'GE 103', 'The Contemporary World', 3.0, 1.25, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:35'),
(89, 5, NULL, 'GE 104', 'Mathematics in the Modern World', 3.0, 1.00, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:36'),
(90, 5, NULL, 'GE 105', 'Purposive Communication', 3.0, 1.25, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:36'),
(91, 5, NULL, 'GE 106', 'Art Appreciation', 3.0, 1.50, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:36'),
(92, 5, NULL, 'GE 107', 'Science, Technology, and Society', 3.0, 1.25, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:36'),
(93, 5, NULL, 'GE 108', 'Ethics', 3.0, 1.25, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:36'),
(94, 5, NULL, 'GE 109', 'Life and Works of Rizal', 3.0, 1.25, 1, 'General Education', 'PASSED', 'Mandated GE', '2026-10-19 16:52:36'),
(95, 5, NULL, 'GE 110', 'Environmental Science', 3.0, 1.25, 1, 'General Education', 'PASSED', 'GE Elective', '2026-10-19 16:52:36'),
(96, 5, NULL, 'GE 111', 'Gender and Society', 3.0, 1.25, 1, 'General Education', 'PASSED', 'GE Elective', '2026-10-19 16:52:36'),
(97, 5, NULL, 'GE 112', 'Philippine Indigenous Communities', 3.0, 1.25, 1, 'General Education', 'PASSED', 'GE Elective', '2026-10-19 16:52:36'),
(98, 5, NULL, 'CE 499', 'Practicum / On-the-Job Training', 6.0, 1.25, 1, 'Practicum', 'PASSED', 'DPWH Region XI • 480 Hours Completed', '2026-10-19 16:52:36'),
(99, 5, NULL, 'CE-E1', 'Earthquake Engineering', 3.0, 1.25, 1, 'Electives', 'PASSED', 'Structural Track', '2026-10-19 16:52:36'),
(100, 5, NULL, 'CE-E2', 'Bridge Engineering', 3.0, 1.25, 1, 'Electives', 'PASSED', 'Structural Track', '2026-10-19 16:52:36'),
(101, 5, NULL, 'CE-E3', 'Foundation Engineering', 3.0, 1.25, 1, 'Electives', 'PASSED', 'Structural Track', '2026-10-19 16:52:36'),
(102, 5, NULL, 'CE-E4', 'Structural Dynamics', 3.0, 1.50, 1, 'Electives', 'PASSED', 'Structural Track', '2026-10-19 16:52:36'),
(103, 5, NULL, 'CE-E5', 'Prestressed Concrete Design', 3.0, 1.25, 1, 'Electives', 'PASSED', 'Structural Track', '2026-10-19 16:52:36'),
(104, 5, NULL, 'CE-E6', 'Retrofitting of Structures', 3.0, 1.25, 1, 'Electives', 'PASSED', 'Structural Track', '2026-10-19 16:52:36'),
(105, 14, NULL, 'IT 101', 'Intro to Computing', 3.0, 1.75, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:36'),
(106, 14, NULL, 'IT 122', 'Web Development Fundamentals', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:36'),
(107, 14, NULL, 'IT 211', 'Object-Oriented Programming', 3.0, 1.75, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(108, 14, NULL, 'IT 214', 'Data Structures & Algorithms', 3.0, 2.00, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(109, 14, NULL, 'IT 223', 'Advanced Web Systems', 3.0, 1.75, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(110, 14, NULL, 'IT 311', 'Database Systems', 3.0, 1.75, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(111, 14, NULL, 'IT 312', 'Information Assurance & Security', 3.0, 2.00, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(112, 14, NULL, 'IT 321', 'Networking 1 & 2', 6.0, 1.75, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(113, 14, NULL, 'IT 322', 'Systems Analysis & Design', 3.0, 1.75, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(114, 14, NULL, 'IT 411', 'Capstone Project I', 3.0, 1.50, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(115, 14, NULL, 'IT 421', 'Capstone Project II', 3.0, 0.00, 1, 'Major', 'INCOMPLETE', 'Incomplete: Lacks final manuscript sign-off', '2026-10-19 16:52:37'),
(116, 14, NULL, 'IT-MAJOR-OTHERS', 'IT Core & Professional Courses', 49.0, 1.80, 1, 'Major', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(117, 14, NULL, 'GE-CORE', 'General Education Core Sequence', 36.0, 1.75, 1, 'General Education', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(118, 14, NULL, 'IT-PRAC', 'IT Industry Internship (480 Hours)', 6.0, 1.50, 1, 'Practicum', 'PASSED', 'Passed', '2026-10-19 16:52:37'),
(119, 14, NULL, 'IT-ELEC', 'Technical Electives Sequence', 16.0, 1.75, 1, 'Electives', 'PASSED', 'Passed', '2026-10-19 16:52:37');

-- --------------------------------------------------------

--
-- Table structure for table `student_records`
--

CREATE TABLE `student_records` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_no` varchar(30) NOT NULL,
  `college_id` int(11) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `curriculum_id` int(11) DEFAULT NULL,
  `year_level` tinyint(4) NOT NULL DEFAULT 1,
  `classification` enum('Regular','Irregular') DEFAULT 'Regular',
  `standing` varchar(50) DEFAULT 'Good Standing',
  `enrollment_status` enum('Active','On Leave','Graduated','Dropped') DEFAULT 'Active',
  `admission_date` date DEFAULT NULL,
  `units_earned` decimal(5,1) DEFAULT 0.0,
  `gwa` decimal(4,2) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_records`
--

INSERT INTO `student_records` (`id`, `user_id`, `student_no`, `college_id`, `program_id`, `curriculum_id`, `year_level`, `classification`, `standing`, `enrollment_status`, `admission_date`, `units_earned`, `gwa`, `updated_at`) VALUES
(1, 2, '2019-01289', 3, 7, 1, 4, 'Regular', 'Good Standing', 'Active', '2019-06-10', 128.0, 1.42, '2026-10-19 18:28:54'),
(3, 5, '2023-01421', 1, 2, 2, 4, 'Regular', 'Good Standing', 'Active', '2023-08-14', 143.0, 1.45, '2026-10-19 16:37:32'),
(4, 6, '2022-00612', 2, 4, 3, 2, 'Regular', 'Regular 2nd Year Standing', 'On Leave', '2022-08-15', 86.0, 1.34, '2026-10-19 18:28:54'),
(5, 7, '2020-00892', 3, 7, 5, 4, 'Regular', 'Alumnus / Degree Conferred', 'Graduated', '2020-08-10', 148.0, 1.34, '2026-10-19 18:07:20'),
(6, 8, '2021-01048', 5, 37, 1, 3, 'Regular', 'Regular Standing', 'Active', '2021-08-16', 112.0, 1.75, '2026-10-19 18:28:54'),
(12, 16, '2020-01124', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 146.0, 1.18, '2026-10-19 16:36:05'),
(13, 18, '2019-04421', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 154.0, 1.62, '2026-10-19 16:37:32'),
(14, 19, '2020-01892', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 140.0, 1.78, '2026-10-19 16:37:32'),
(15, 20, '2020-10006', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.51, '2026-10-19 16:37:37'),
(16, 21, '2020-10007', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.60, '2026-10-19 16:37:38'),
(17, 22, '2020-10008', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.12, '2026-10-19 16:37:38'),
(18, 23, '2020-10009', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.32, '2026-10-19 16:37:38'),
(19, 24, '2020-10010', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.13, '2026-10-19 16:37:38'),
(20, 25, '2020-10011', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.44, '2026-10-19 16:37:38'),
(21, 26, '2020-10012', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.54, '2026-10-19 16:37:38'),
(22, 27, '2020-10013', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.63, '2026-10-19 16:37:39'),
(23, 28, '2020-10014', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.51, '2026-10-19 16:37:39'),
(24, 29, '2020-10015', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.83, '2026-10-19 16:37:39'),
(25, 30, '2020-10016', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.30, '2026-10-19 16:37:39'),
(26, 31, '2020-10017', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.58, '2026-10-19 16:37:39'),
(27, 32, '2020-10018', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.01, '2026-10-19 16:37:39'),
(28, 33, '2020-10019', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.59, '2026-10-19 16:37:39'),
(29, 34, '2020-10020', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.96, '2026-10-19 16:37:39'),
(30, 35, '2020-10021', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.29, '2026-10-19 16:37:40'),
(31, 36, '2020-10022', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.22, '2026-10-19 16:37:40'),
(32, 37, '2020-10023', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.16, '2026-10-19 16:37:40'),
(33, 38, '2020-10024', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.52, '2026-10-19 16:37:40'),
(34, 39, '2020-10025', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.36, '2026-10-19 16:37:40'),
(35, 40, '2020-10026', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.73, '2026-10-19 16:37:40'),
(36, 41, '2020-10027', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.39, '2026-10-19 16:37:41'),
(37, 42, '2020-10028', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.54, '2026-10-19 16:37:41'),
(38, 43, '2020-10029', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.64, '2026-10-19 16:37:41'),
(39, 44, '2020-10030', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.52, '2026-10-19 16:37:41'),
(40, 45, '2020-10031', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.52, '2026-10-19 16:37:42'),
(41, 46, '2020-10032', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.80, '2026-10-19 16:37:42'),
(42, 47, '2020-10033', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.33, '2026-10-19 16:37:42'),
(43, 48, '2020-10034', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.44, '2026-10-19 16:37:42'),
(44, 49, '2020-10035', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.00, '2026-10-19 16:37:42'),
(45, 50, '2020-10036', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.44, '2026-10-19 16:37:42'),
(46, 51, '2020-10037', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.30, '2026-10-19 16:37:42'),
(47, 52, '2020-10038', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.99, '2026-10-19 16:37:43'),
(48, 53, '2020-10039', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.11, '2026-10-19 16:37:44'),
(49, 54, '2020-10040', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.98, '2026-10-19 16:37:44'),
(50, 55, '2020-10041', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.56, '2026-10-19 16:37:44'),
(51, 56, '2020-10042', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.05, '2026-10-19 16:37:44'),
(52, 57, '2020-10043', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.51, '2026-10-19 16:37:44'),
(53, 58, '2020-10044', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.13, '2026-10-19 16:37:44'),
(54, 59, '2020-10045', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.89, '2026-10-19 16:37:44'),
(55, 60, '2020-10046', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.54, '2026-10-19 16:37:44'),
(56, 61, '2020-10047', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.78, '2026-10-19 16:37:44'),
(57, 62, '2020-10048', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.47, '2026-10-19 16:37:45'),
(58, 63, '2020-10049', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.19, '2026-10-19 16:37:45'),
(59, 64, '2020-10050', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.83, '2026-10-19 16:37:45'),
(60, 65, '2020-10051', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.04, '2026-10-19 16:37:45'),
(61, 66, '2020-10052', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.07, '2026-10-19 16:37:45'),
(62, 67, '2020-10053', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.37, '2026-10-19 16:37:45'),
(63, 68, '2020-10054', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.67, '2026-10-19 16:37:45'),
(64, 69, '2020-10055', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.65, '2026-10-19 16:37:46'),
(65, 70, '2020-10056', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.57, '2026-10-19 16:37:46'),
(66, 71, '2020-10057', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.57, '2026-10-19 16:37:46'),
(67, 72, '2020-10058', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.35, '2026-10-19 16:37:46'),
(68, 73, '2020-10059', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.40, '2026-10-19 16:37:46'),
(69, 74, '2020-10060', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.41, '2026-10-19 16:37:46'),
(70, 75, '2020-10061', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.54, '2026-10-19 16:37:47'),
(71, 76, '2020-10062', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.33, '2026-10-19 16:37:47'),
(72, 77, '2020-10063', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.77, '2026-10-19 16:37:47'),
(73, 78, '2020-10064', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.26, '2026-10-19 16:37:47'),
(74, 79, '2020-10065', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.38, '2026-10-19 16:37:47'),
(75, 80, '2020-10066', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.59, '2026-10-19 16:37:48'),
(76, 81, '2020-10067', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.58, '2026-10-19 16:37:49'),
(77, 82, '2020-10068', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.55, '2026-10-19 16:37:49'),
(78, 83, '2020-10069', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.65, '2026-10-19 16:37:49'),
(79, 84, '2020-10070', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.26, '2026-10-19 16:37:49'),
(80, 85, '2020-10071', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.43, '2026-10-19 16:37:50'),
(81, 86, '2020-10072', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.48, '2026-10-19 16:37:50'),
(82, 87, '2020-10073', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.27, '2026-10-19 16:37:50'),
(83, 88, '2020-10074', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.97, '2026-10-19 16:37:51'),
(84, 89, '2020-10075', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.04, '2026-10-19 16:37:51'),
(85, 90, '2020-10076', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.55, '2026-10-19 16:37:51'),
(86, 91, '2020-10077', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.84, '2026-10-19 16:37:51'),
(87, 92, '2020-10078', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.26, '2026-10-19 16:37:51'),
(88, 93, '2020-10079', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.73, '2026-10-19 16:37:52'),
(89, 94, '2020-10080', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.82, '2026-10-19 16:37:52'),
(90, 95, '2020-10081', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.65, '2026-10-19 16:37:52'),
(91, 96, '2020-10082', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.34, '2026-10-19 16:37:52'),
(92, 97, '2020-10083', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.87, '2026-10-19 16:37:52'),
(93, 98, '2020-10084', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.05, '2026-10-19 16:37:52'),
(94, 99, '2020-10085', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.86, '2026-10-19 16:37:53'),
(95, 100, '2020-10086', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.54, '2026-10-19 16:37:53'),
(96, 101, '2020-10087', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.49, '2026-10-19 16:37:53'),
(97, 102, '2020-10088', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.94, '2026-10-19 16:37:53'),
(98, 103, '2020-10089', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.34, '2026-10-19 16:37:53'),
(99, 104, '2020-10090', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.31, '2026-10-19 16:37:53'),
(100, 105, '2020-10091', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.39, '2026-10-19 16:37:54'),
(101, 106, '2020-10092', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.72, '2026-10-19 16:37:55'),
(102, 107, '2020-10093', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.49, '2026-10-19 16:37:55'),
(103, 108, '2020-10094', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.12, '2026-10-19 16:37:55'),
(104, 109, '2020-10095', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.95, '2026-10-19 16:37:55'),
(105, 110, '2020-10096', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.75, '2026-10-19 16:37:55'),
(106, 111, '2020-10097', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.64, '2026-10-19 16:37:55'),
(107, 112, '2020-10098', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.96, '2026-10-19 16:37:56'),
(108, 113, '2020-10099', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.52, '2026-10-19 16:37:56'),
(109, 114, '2020-10100', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.21, '2026-10-19 16:37:56'),
(110, 115, '2020-10101', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.20, '2026-10-19 16:37:56'),
(111, 116, '2020-10102', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.56, '2026-10-19 16:37:57'),
(112, 117, '2020-10103', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.31, '2026-10-19 16:37:57'),
(113, 118, '2020-10104', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.91, '2026-10-19 16:37:57'),
(114, 119, '2020-10105', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.46, '2026-10-19 16:37:57'),
(115, 120, '2020-10106', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.02, '2026-10-19 16:37:57'),
(116, 121, '2020-10107', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.77, '2026-10-19 16:37:57'),
(117, 122, '2020-10108', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.20, '2026-10-19 16:37:57'),
(118, 123, '2020-10109', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.11, '2026-10-19 16:37:57'),
(119, 124, '2020-10110', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.36, '2026-10-19 16:37:57'),
(120, 125, '2020-10111', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.52, '2026-10-19 16:37:58'),
(121, 126, '2020-10112', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.49, '2026-10-19 16:37:58'),
(122, 127, '2020-10113', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.96, '2026-10-19 16:37:58'),
(123, 128, '2020-10114', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.39, '2026-10-19 16:37:58'),
(124, 129, '2020-10115', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.72, '2026-10-19 16:37:58'),
(125, 130, '2020-10116', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.62, '2026-10-19 16:37:58'),
(126, 131, '2020-10117', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.43, '2026-10-19 16:37:59'),
(127, 132, '2020-10118', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.25, '2026-10-19 16:38:00'),
(128, 133, '2020-10119', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.18, '2026-10-19 16:38:00'),
(129, 134, '2020-10120', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.53, '2026-10-19 16:38:01'),
(130, 135, '2020-10121', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.72, '2026-10-19 16:38:01'),
(131, 136, '2020-10122', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.50, '2026-10-19 16:38:01'),
(132, 137, '2020-10123', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.24, '2026-10-19 16:38:01'),
(133, 138, '2020-10124', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.97, '2026-10-19 16:38:01'),
(134, 139, '2020-10125', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.71, '2026-10-19 16:38:01'),
(135, 140, '2020-10126', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.22, '2026-10-19 16:38:01'),
(136, 141, '2020-10127', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.27, '2026-10-19 16:38:02'),
(137, 142, '2020-10128', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.44, '2026-10-19 16:38:02'),
(138, 143, '2020-10129', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.37, '2026-10-19 16:38:02'),
(139, 144, '2020-10130', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.06, '2026-10-19 16:38:02'),
(140, 145, '2020-10131', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.48, '2026-10-19 16:38:02'),
(141, 146, '2020-10132', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.42, '2026-10-19 16:38:02'),
(142, 147, '2020-10133', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.40, '2026-10-19 16:38:02'),
(143, 148, '2020-10134', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.81, '2026-10-19 16:38:03'),
(144, 149, '2020-10135', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.45, '2026-10-19 16:38:03'),
(145, 150, '2020-10136', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.60, '2026-10-19 16:38:03'),
(146, 151, '2020-10137', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.01, '2026-10-19 16:38:03'),
(147, 152, '2020-10138', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.36, '2026-10-19 16:38:03'),
(148, 153, '2020-10139', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.31, '2026-10-19 16:38:04'),
(149, 154, '2020-10140', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.15, '2026-10-19 16:38:04'),
(150, 155, '2020-10141', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.71, '2026-10-19 16:38:04'),
(151, 156, '2020-10142', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.49, '2026-10-19 16:38:05'),
(152, 157, '2020-10143', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.85, '2026-10-19 16:38:05'),
(153, 158, '2020-10144', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.31, '2026-10-19 16:38:05'),
(154, 159, '2020-10145', 3, 7, 5, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.31, '2026-10-19 16:38:06'),
(155, 160, '2020-10146', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.49, '2026-10-19 16:38:06'),
(156, 161, '2020-10147', 1, 2, 2, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 2.33, '2026-10-19 16:38:06'),
(157, 162, '2020-10148', 1, 1, 1, 4, 'Regular', 'Graduating Senior', 'Active', NULL, 148.0, 1.93, '2026-10-19 16:38:06');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `units` decimal(3,1) NOT NULL DEFAULT 3.0,
  `college_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `code`, `title`, `units`, `college_id`, `created_at`) VALUES
(1, 'IT 214', 'Data Structures & Algorithms', 3.0, 1, '2026-10-19 14:13:56'),
(2, 'IT 223', 'Advanced Web Systems', 3.0, 1, '2026-10-19 14:13:56'),
(3, 'IT 122', 'Web Development Fundamentals', 3.0, 1, '2026-10-19 14:13:56'),
(4, 'IT 211', 'Object-Oriented Programming', 3.0, 1, '2026-10-19 14:13:56'),
(5, 'GE 104', 'Readings in Philippine History', 3.0, 2, '2026-10-19 14:13:56'),
(6, 'PE 3', 'Physical Education 3 (Individual/Dual Sports)', 2.0, 5, '2026-10-19 14:13:56'),
(7, 'CS 412', 'Intelligent Systems', 3.0, 1, '2026-10-19 14:13:56'),
(8, 'CE 311', 'Structural Theory', 4.0, 3, '2026-10-19 14:13:56'),
(9, 'ENT 201', 'Opportunity Seeking', 3.0, 5, '2026-10-19 14:13:56'),
(10, 'IT 214', 'Data Structures & Algorithms', 3.0, 1, '2026-10-19 14:15:02'),
(11, 'IT 223', 'Advanced Web Systems', 3.0, 1, '2026-10-19 14:15:02'),
(12, 'IT 122', 'Web Development Fundamentals', 3.0, 1, '2026-10-19 14:15:02'),
(13, 'IT 211', 'Object-Oriented Programming', 3.0, 1, '2026-10-19 14:15:02'),
(14, 'GE 104', 'Readings in Philippine History', 3.0, 2, '2026-10-19 14:15:02'),
(15, 'PE 3', 'Physical Education 3 (Individual/Dual Sports)', 2.0, 5, '2026-10-19 14:15:03'),
(16, 'CS 412', 'Intelligent Systems', 3.0, 1, '2026-10-19 14:15:03'),
(17, 'CE 311', 'Structural Theory', 4.0, 3, '2026-10-19 14:15:03'),
(18, 'ENT 201', 'Opportunity Seeking', 3.0, 5, '2026-10-19 14:15:03'),
(19, 'IT 214', 'Data Structures & Algorithms', 3.0, 1, '2026-10-19 14:27:33'),
(20, 'IT 223', 'Advanced Web Systems', 3.0, 1, '2026-10-19 14:27:33'),
(21, 'IT 122', 'Web Development Fundamentals', 3.0, 1, '2026-10-19 14:27:34'),
(22, 'IT 211', 'Object-Oriented Programming', 3.0, 1, '2026-10-19 14:27:34'),
(23, 'GE 104', 'Readings in Philippine History', 3.0, 2, '2026-10-19 14:27:34'),
(24, 'PE 3', 'Physical Education 3 (Individual/Dual Sports)', 2.0, 5, '2026-10-19 14:27:34'),
(25, 'CS 412', 'Intelligent Systems', 3.0, 1, '2026-10-19 14:27:34'),
(26, 'CE 311', 'Structural Theory', 4.0, 3, '2026-10-19 14:27:34'),
(27, 'ENT 201', 'Opportunity Seeking', 3.0, 5, '2026-10-19 14:27:34'),
(28, 'IT 214', 'Data Structures & Algorithms', 3.0, 1, '2026-10-19 15:30:24'),
(29, 'IT 223', 'Advanced Web Systems', 3.0, 1, '2026-10-19 15:30:24'),
(30, 'IT 122', 'Web Development Fundamentals', 3.0, 1, '2026-10-19 15:30:24'),
(31, 'IT 211', 'Object-Oriented Programming', 3.0, 1, '2026-10-19 15:30:24'),
(32, 'GE 104', 'Readings in Philippine History', 3.0, 2, '2026-10-19 15:30:24'),
(33, 'PE 3', 'Physical Education 3 (Individual/Dual Sports)', 2.0, 5, '2026-10-19 15:30:24'),
(34, 'CS 412', 'Intelligent Systems', 3.0, 1, '2026-10-19 15:30:24'),
(35, 'CE 311', 'Structural Theory', 4.0, 3, '2026-10-19 15:30:24'),
(36, 'ENT 201', 'Opportunity Seeking', 3.0, 5, '2026-10-19 15:30:24'),
(37, 'GE 101', 'Understanding the Self', 3.0, 2, '2026-10-19 15:37:06'),
(38, 'GE 102', 'Purposive Communication', 3.0, 2, '2026-10-19 15:37:07'),
(39, 'GE 103', 'The Contemporary World', 3.0, 2, '2026-10-19 15:37:08'),
(40, 'PSYCH 101', 'Introduction to Psychology', 3.0, 2, '2026-10-19 15:37:08'),
(41, 'PSYCH 102', 'Psychological Statistics', 3.0, 2, '2026-10-19 15:37:08'),
(42, 'PSYCH 103', 'Developmental Psychology', 3.0, 2, '2026-10-19 15:37:08'),
(43, 'NATSCI 101', 'General Biological Sciences (Lecture & Lab)', 5.0, 2, '2026-10-19 15:37:08'),
(44, 'COMM 101', 'Introduction to Communication', 3.0, 2, '2026-10-19 15:37:08'),
(45, 'COMM 104', 'Communication Media', 3.0, 2, '2026-10-19 15:37:08');

-- --------------------------------------------------------

--
-- Table structure for table `subject_prerequisites`
--

CREATE TABLE `subject_prerequisites` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `prerequisite_subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subject_prerequisites`
--

INSERT INTO `subject_prerequisites` (`id`, `subject_id`, `prerequisite_subject_id`) VALUES
(1, 2, 3),
(2, 7, 1),
(3, 11, 12),
(4, 16, 10),
(5, 20, 21),
(6, 25, 19),
(7, 29, 30),
(8, 34, 28);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_key`, `setting_value`, `description`, `updated_at`) VALUES
('adddrop_policy_code', 'IRR-2024-C', 'Official Academic Policy Guideline Code', '2026-10-19 14:13:56'),
('honors_cum_laude_gwa_threshold', '1.75', 'Maximum GWA for Cum Laude (inclusive)', '2026-10-19 16:36:03'),
('honors_disqualify_on_failing_grade', '1', 'Disqualify Latin honors if student has any failing or dropped grade (1=yes, 0=no)', '2026-10-19 16:36:04'),
('honors_magna_gwa_threshold', '1.45', 'Maximum GWA for Magna Cum Laude (inclusive)', '2026-10-19 16:36:03'),
('honors_summa_gwa_threshold', '1.20', 'Maximum GWA for Summa Cum Laude (inclusive)', '2026-10-19 16:36:03'),
('loa_policy_note', 'Under USeP Code Chapter IV, Section 12: Students who went on official leave of absence for not more than one year may be readmitted directly upon submission of clinic clearance and dean endorsement without retaking the University Admission Assessment.', 'Official policy text for readmission after approved LOA', '2026-10-19 18:28:52'),
('mrr_max_years', '6.0', 'Maximum Residency Rule (MRR) maximum allowable tenure in academic years', '2026-10-19 18:28:52'),
('mrr_warning_threshold_years', '5.5', 'MRR warning threshold requiring Vice President for Academic Affairs approval', '2026-10-19 18:28:52'),
('program_curriculum_total_units_default', '150.0', 'Standard total curriculum units for degree programs', '2026-10-19 15:37:02'),
('shifting_honors_gwa_threshold', '1.50', 'GWA threshold to qualify for Deans Honors distinction in shifting', '2026-10-19 15:37:02'),
('shifting_transferee_min_gwa', '2.00', 'Minimum cumulative GWA required for program transfer/shifting', '2026-10-19 15:37:02'),
('tuition_per_unit', '250.00', 'Tuition assessment per academic unit (PHP)', '2026-10-19 14:13:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `university_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('student','admin','registrar','cashier') NOT NULL DEFAULT 'student',
  `college` varchar(100) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
  `civil_status` varchar(50) DEFAULT 'Single',
  `contact_number` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `university_id`, `first_name`, `middle_name`, `last_name`, `email`, `password_hash`, `role`, `college`, `program`, `birthdate`, `gender`, `place_of_birth`, `civil_status`, `contact_number`, `created_at`) VALUES
(1, 'REG-ADMIN-04', 'Registrar', NULL, 'Admin', 'admin@usep.edu.ph', '$2y$10$6CQ8b6gJlVHJDgxdo33oUOtwT1YKoMZ8p79SNc4vu4HHTvvZkLYYa', 'admin', NULL, NULL, NULL, NULL, NULL, 'Single', '+63 917 880 0024', '2026-10-06 12:54:12'),
(2, '2021-04182', 'Joshua', 'Manuel', 'Pearce', 'joshua@usep.edu.ph', '$2y$10$/Koyp37hqcYtDiqSELEXq.xV.fL8OMesKRbap1FjZJw4v3nYA0IAW', 'student', 'College of Information and Computing', 'BS Computer Science', '2003-05-14', 'Male', 'Davao City', 'Single', '+63 947 882 1094', '2026-10-06 12:54:12'),
(5, '2023-01421', 'Paolo R.', 'R.', 'Reyes', 'paolo@usep.edu.ph', '$2y$10$gk.mk5ggiWuWWP5dQ93LjOR3h7Ie6nWJ3HiPl4IbdpbROhwe/NJQG', 'student', 'College of Information and Computing', 'BS Information Technology', '2004-11-20', 'Male', 'Digos City', 'Single', '+63 919 443 8912', '2026-10-19 12:02:10'),
(6, '2022-00612', 'Ana C.', 'C.', 'Flores', 'ana@usep.edu.ph', '$2y$10$gk.mk5ggiWuWWP5dQ93LjOR3h7Ie6nWJ3HiPl4IbdpbROhwe/NJQG', 'student', 'College of Arts and Sciences', 'BS Psychology', '2003-09-08', 'Female', 'Panabo City', 'Single', '+63 928 331 4455', '2026-10-19 12:02:10'),
(7, '2020-00892', 'Mark', 'T.', 'Lim', 'mark@usep.edu.ph', '$2y$10$gk.mk5ggiWuWWP5dQ93LjOR3h7Ie6nWJ3HiPl4IbdpbROhwe/NJQG', 'student', 'College of Engineering', 'BS Civil Engineering', '2002-01-25', 'Male', 'Davao City', 'Single', '+63 915 672 8841', '2026-10-19 12:02:11'),
(8, '2023-00431', 'Lea B.', 'B.', 'Ramos', 'lea@usep.edu.ph', '$2y$10$gk.mk5ggiWuWWP5dQ93LjOR3h7Ie6nWJ3HiPl4IbdpbROhwe/NJQG', 'student', 'College of Teacher Education', 'BS Secondary Education', '2004-03-18', 'Female', 'Mati City', 'Single', '+63 939 772 1088', '2026-10-19 12:02:11'),
(16, '', 'Althea', NULL, 'Ramos', 'althea@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:36:05'),
(18, '2019-04421', 'Joshua', NULL, 'Dela Cruz', 'joshua.delacruz@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:32'),
(19, '2020-01892', 'Catherine', NULL, 'Mercado', 'catherine@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:32'),
(20, '2020-10006', 'Kim', NULL, 'Bautista', 'kim.bautista6@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:36'),
(21, '2020-10007', 'John', NULL, 'Tomas', 'john.tomas7@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:37'),
(22, '2020-10008', 'Kim', NULL, 'Bautista', 'kim.bautista8@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:38'),
(23, '2020-10009', 'Jerome', NULL, 'Ocampo', 'jerome.ocampo9@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:38'),
(24, '2020-10010', 'Diana', NULL, 'Bautista', 'diana.bautista10@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:38'),
(25, '2020-10011', 'Anthony', NULL, 'Ocampo', 'anthony.ocampo11@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:38'),
(26, '2020-10012', 'Maria', NULL, 'Villanueva', 'maria.villanueva12@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:38'),
(27, '2020-10013', 'Daniel', NULL, 'Cruz', 'daniel.cruz13@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:38'),
(28, '2020-10014', 'Bea', NULL, 'Mendoza', 'bea.mendoza14@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(29, '2020-10015', 'John', NULL, 'Castillo', 'john.castillo15@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(30, '2020-10016', 'Patricia', NULL, 'Tomas', 'patricia.tomas16@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(31, '2020-10017', 'Patricia', NULL, 'Mendoza', 'patricia.mendoza17@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(32, '2020-10018', 'Carlo', NULL, 'Bautista', 'carlo.bautista18@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(33, '2020-10019', 'Bea', NULL, 'Tomas', 'bea.tomas19@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(34, '2020-10020', 'Patricia', NULL, 'Tomas', 'patricia.tomas20@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(35, '2020-10021', 'Anthony', NULL, 'Roxas', 'anthony.roxas21@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:39'),
(36, '2020-10022', 'Maria', NULL, 'Tomas', 'maria.tomas22@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:40'),
(37, '2020-10023', 'Christian', NULL, 'Bautista', 'christian.bautista23@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:40'),
(38, '2020-10024', 'Nicole', NULL, 'Torres', 'nicole.torres24@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:40'),
(39, '2020-10025', 'Patricia', NULL, 'Ocampo', 'patricia.ocampo25@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:40'),
(40, '2020-10026', 'Sarah', NULL, 'Torres', 'sarah.torres26@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:40'),
(41, '2020-10027', 'Bea', NULL, 'Mendoza', 'bea.mendoza27@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:41'),
(42, '2020-10028', 'John', NULL, 'Cruz', 'john.cruz28@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:41'),
(43, '2020-10029', 'Jerome', NULL, 'Mendoza', 'jerome.mendoza29@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:41'),
(44, '2020-10030', 'Daniel', NULL, 'Castillo', 'daniel.castillo30@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:41'),
(45, '2020-10031', 'Anthony', NULL, 'Torres', 'anthony.torres31@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:41'),
(46, '2020-10032', 'John', NULL, 'Aquino', 'john.aquino32@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:42'),
(47, '2020-10033', 'Sarah', NULL, 'Castillo', 'sarah.castillo33@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:42'),
(48, '2020-10034', 'Carlo', NULL, 'Bautista', 'carlo.bautista34@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:42'),
(49, '2020-10035', 'Christian', NULL, 'Tomas', 'christian.tomas35@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:42'),
(50, '2020-10036', 'Patricia', NULL, 'Garcia', 'patricia.garcia36@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:42'),
(51, '2020-10037', 'Maria', NULL, 'Tomas', 'maria.tomas37@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:42'),
(52, '2020-10038', 'Christian', NULL, 'Roxas', 'christian.roxas38@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:43'),
(53, '2020-10039', 'Anthony', NULL, 'Ocampo', 'anthony.ocampo39@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(54, '2020-10040', 'Kim', NULL, 'Torres', 'kim.torres40@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(55, '2020-10041', 'Carlo', NULL, 'Ocampo', 'carlo.ocampo41@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(56, '2020-10042', 'Bea', NULL, 'Villanueva', 'bea.villanueva42@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(57, '2020-10043', 'Christian', NULL, 'Roxas', 'christian.roxas43@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(58, '2020-10044', 'Kim', NULL, 'Villanueva', 'kim.villanueva44@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(59, '2020-10045', 'Kim', NULL, 'Aquino', 'kim.aquino45@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(60, '2020-10046', 'Sarah', NULL, 'Santos', 'sarah.santos46@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(61, '2020-10047', 'Diana', NULL, 'Torres', 'diana.torres47@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:44'),
(62, '2020-10048', 'Anthony', NULL, 'Cruz', 'anthony.cruz48@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(63, '2020-10049', 'Anthony', NULL, 'Garcia', 'anthony.garcia49@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(64, '2020-10050', 'Anthony', NULL, 'Santos', 'anthony.santos50@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(65, '2020-10051', 'Jerome', NULL, 'Torres', 'jerome.torres51@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(66, '2020-10052', 'Carlo', NULL, 'Torres', 'carlo.torres52@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(67, '2020-10053', 'Daniel', NULL, 'Villanueva', 'daniel.villanueva53@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(68, '2020-10054', 'Patricia', NULL, 'Ocampo', 'patricia.ocampo54@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:45'),
(69, '2020-10055', 'John', NULL, 'Santos', 'john.santos55@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:46'),
(70, '2020-10056', 'Maria', NULL, 'Roxas', 'maria.roxas56@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:46'),
(71, '2020-10057', 'Sarah', NULL, 'Roxas', 'sarah.roxas57@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:46'),
(72, '2020-10058', 'Gabriel', NULL, 'Mendoza', 'gabriel.mendoza58@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:46'),
(73, '2020-10059', 'Daniel', NULL, 'Torres', 'daniel.torres59@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:46'),
(74, '2020-10060', 'Daniel', NULL, 'Cruz', 'daniel.cruz60@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:46'),
(75, '2020-10061', 'Maria', NULL, 'Garcia', 'maria.garcia61@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:47'),
(76, '2020-10062', 'Daniel', NULL, 'Villanueva', 'daniel.villanueva62@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:47'),
(77, '2020-10063', 'Christian', NULL, 'Cruz', 'christian.cruz63@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:47'),
(78, '2020-10064', 'Carlo', NULL, 'Ocampo', 'carlo.ocampo64@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:47'),
(79, '2020-10065', 'Carlo', NULL, 'Santos', 'carlo.santos65@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:47'),
(80, '2020-10066', 'Daniel', NULL, 'Castillo', 'daniel.castillo66@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:48'),
(81, '2020-10067', 'Diana', NULL, 'Castillo', 'diana.castillo67@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:48'),
(82, '2020-10068', 'Anthony', NULL, 'Aquino', 'anthony.aquino68@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:49'),
(83, '2020-10069', 'Maria', NULL, 'Bautista', 'maria.bautista69@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:49'),
(84, '2020-10070', 'Kim', NULL, 'Garcia', 'kim.garcia70@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:49'),
(85, '2020-10071', 'John', NULL, 'Aquino', 'john.aquino71@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:49'),
(86, '2020-10072', 'Diana', NULL, 'Cruz', 'diana.cruz72@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:50'),
(87, '2020-10073', 'Carlo', NULL, 'Tomas', 'carlo.tomas73@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:50'),
(88, '2020-10074', 'Nicole', NULL, 'Ocampo', 'nicole.ocampo74@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:51'),
(89, '2020-10075', 'Daniel', NULL, 'Castillo', 'daniel.castillo75@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:51'),
(90, '2020-10076', 'Christian', NULL, 'Aquino', 'christian.aquino76@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:51'),
(91, '2020-10077', 'Kim', NULL, 'Aquino', 'kim.aquino77@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:51'),
(92, '2020-10078', 'Gabriel', NULL, 'Santos', 'gabriel.santos78@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:51'),
(93, '2020-10079', 'Maria', NULL, 'Tomas', 'maria.tomas79@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:51'),
(94, '2020-10080', 'Bea', NULL, 'Bautista', 'bea.bautista80@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:52'),
(95, '2020-10081', 'Christian', NULL, 'Villanueva', 'christian.villanueva81@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:52'),
(96, '2020-10082', 'John', NULL, 'Cruz', 'john.cruz82@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:52'),
(97, '2020-10083', 'Nicole', NULL, 'Torres', 'nicole.torres83@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:52'),
(98, '2020-10084', 'Diana', NULL, 'Tomas', 'diana.tomas84@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:52'),
(99, '2020-10085', 'Patricia', NULL, 'Torres', 'patricia.torres85@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:52'),
(100, '2020-10086', 'Sarah', NULL, 'Aquino', 'sarah.aquino86@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:53'),
(101, '2020-10087', 'John', NULL, 'Mendoza', 'john.mendoza87@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:53'),
(102, '2020-10088', 'Daniel', NULL, 'Roxas', 'daniel.roxas88@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:53'),
(103, '2020-10089', 'Maria', NULL, 'Aquino', 'maria.aquino89@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:53'),
(104, '2020-10090', 'Kim', NULL, 'Aquino', 'kim.aquino90@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:53'),
(105, '2020-10091', 'John', NULL, 'Mendoza', 'john.mendoza91@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:53'),
(106, '2020-10092', 'Sarah', NULL, 'Torres', 'sarah.torres92@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:54'),
(107, '2020-10093', 'Anthony', NULL, 'Villanueva', 'anthony.villanueva93@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:55'),
(108, '2020-10094', 'Jerome', NULL, 'Villanueva', 'jerome.villanueva94@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:55'),
(109, '2020-10095', 'Bea', NULL, 'Torres', 'bea.torres95@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:55'),
(110, '2020-10096', 'Daniel', NULL, 'Tomas', 'daniel.tomas96@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:55'),
(111, '2020-10097', 'Patricia', NULL, 'Santos', 'patricia.santos97@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:55'),
(112, '2020-10098', 'Christian', NULL, 'Aquino', 'christian.aquino98@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:56'),
(113, '2020-10099', 'Nicole', NULL, 'Aquino', 'nicole.aquino99@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:56'),
(114, '2020-10100', 'Bea', NULL, 'Santos', 'bea.santos100@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:56'),
(115, '2020-10101', 'Patricia', NULL, 'Ocampo', 'patricia.ocampo101@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:56'),
(116, '2020-10102', 'Bea', NULL, 'Bautista', 'bea.bautista102@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(117, '2020-10103', 'Sarah', NULL, 'Castillo', 'sarah.castillo103@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(118, '2020-10104', 'Kim', NULL, 'Ocampo', 'kim.ocampo104@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(119, '2020-10105', 'Daniel', NULL, 'Santos', 'daniel.santos105@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(120, '2020-10106', 'Diana', NULL, 'Santos', 'diana.santos106@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(121, '2020-10107', 'Daniel', NULL, 'Castillo', 'daniel.castillo107@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(122, '2020-10108', 'Nicole', NULL, 'Cruz', 'nicole.cruz108@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(123, '2020-10109', 'Maria', NULL, 'Tomas', 'maria.tomas109@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(124, '2020-10110', 'Daniel', NULL, 'Mendoza', 'daniel.mendoza110@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(125, '2020-10111', 'Sarah', NULL, 'Castillo', 'sarah.castillo111@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:57'),
(126, '2020-10112', 'Nicole', NULL, 'Aquino', 'nicole.aquino112@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:58'),
(127, '2020-10113', 'Christian', NULL, 'Castillo', 'christian.castillo113@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:58'),
(128, '2020-10114', 'Carlo', NULL, 'Cruz', 'carlo.cruz114@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:58'),
(129, '2020-10115', 'Gabriel', NULL, 'Cruz', 'gabriel.cruz115@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:58'),
(130, '2020-10116', 'Diana', NULL, 'Aquino', 'diana.aquino116@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:58'),
(131, '2020-10117', 'Diana', NULL, 'Roxas', 'diana.roxas117@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:37:59'),
(132, '2020-10118', 'Gabriel', NULL, 'Villanueva', 'gabriel.villanueva118@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:00'),
(133, '2020-10119', 'Jerome', NULL, 'Ocampo', 'jerome.ocampo119@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:00'),
(134, '2020-10120', 'Daniel', NULL, 'Tomas', 'daniel.tomas120@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(135, '2020-10121', 'John', NULL, 'Villanueva', 'john.villanueva121@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(136, '2020-10122', 'Jerome', NULL, 'Santos', 'jerome.santos122@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(137, '2020-10123', 'Gabriel', NULL, 'Cruz', 'gabriel.cruz123@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(138, '2020-10124', 'Kim', NULL, 'Tomas', 'kim.tomas124@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(139, '2020-10125', 'Anthony', NULL, 'Garcia', 'anthony.garcia125@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(140, '2020-10126', 'Kim', NULL, 'Villanueva', 'kim.villanueva126@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:01'),
(141, '2020-10127', 'Patricia', NULL, 'Ocampo', 'patricia.ocampo127@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(142, '2020-10128', 'Nicole', NULL, 'Villanueva', 'nicole.villanueva128@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(143, '2020-10129', 'Christian', NULL, 'Tomas', 'christian.tomas129@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(144, '2020-10130', 'Diana', NULL, 'Tomas', 'diana.tomas130@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(145, '2020-10131', 'Bea', NULL, 'Cruz', 'bea.cruz131@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(146, '2020-10132', 'Carlo', NULL, 'Villanueva', 'carlo.villanueva132@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(147, '2020-10133', 'Kim', NULL, 'Tomas', 'kim.tomas133@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:02'),
(148, '2020-10134', 'John', NULL, 'Castillo', 'john.castillo134@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:03'),
(149, '2020-10135', 'Bea', NULL, 'Villanueva', 'bea.villanueva135@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:03'),
(150, '2020-10136', 'Diana', NULL, 'Castillo', 'diana.castillo136@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:03'),
(151, '2020-10137', 'Christian', NULL, 'Garcia', 'christian.garcia137@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:03'),
(152, '2020-10138', 'Jerome', NULL, 'Bautista', 'jerome.bautista138@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:03'),
(153, '2020-10139', 'Daniel', NULL, 'Castillo', 'daniel.castillo139@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:03'),
(154, '2020-10140', 'Patricia', NULL, 'Cruz', 'patricia.cruz140@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:04'),
(155, '2020-10141', 'Christian', NULL, 'Torres', 'christian.torres141@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:04'),
(156, '2020-10142', 'Jerome', NULL, 'Santos', 'jerome.santos142@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:05'),
(157, '2020-10143', 'John', NULL, 'Mendoza', 'john.mendoza143@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:05'),
(158, '2020-10144', 'Carlo', NULL, 'Aquino', 'carlo.aquino144@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:05'),
(159, '2020-10145', 'Jerome', NULL, 'Garcia', 'jerome.garcia145@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:06'),
(160, '2020-10146', 'Jerome', NULL, 'Castillo', 'jerome.castillo146@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:06'),
(161, '2020-10147', 'John', NULL, 'Castillo', 'john.castillo147@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:06'),
(162, '2020-10148', 'Sarah', NULL, 'Ocampo', 'sarah.ocampo148@usep.edu.ph', 'demo_hash', 'student', NULL, NULL, NULL, NULL, NULL, 'Single', NULL, '2026-10-19 16:38:06');

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('present','permanent') NOT NULL,
  `street` varchar(150) DEFAULT NULL,
  `barangay` varchar(100) DEFAULT NULL,
  `city_municipality` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  `region` varchar(100) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `user_id`, `type`, `street`, `barangay`, `city_municipality`, `province`, `region`, `zip_code`, `is_primary`, `created_at`, `updated_at`) VALUES
(11, 2, 'present', '123 University Drive', '', 'Davao City', 'Davao del Sur', '', '8000', 1, '2026-10-19 12:02:42', '2026-10-19 12:09:14'),
(12, 2, 'permanent', 'Purok 4, San Jose Road', 'Poblacion', 'Tagum City', 'Davao del Norte', 'Region XI', '8100', 0, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(13, 5, 'present', 'Unit 3B, University Garden Dormitory', 'Obrero', 'Davao City', 'Davao del Sur', 'Region XI', '8000', 1, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(14, 5, 'permanent', 'Zone 3, Magsaysay St.', 'San Jose', 'Digos City', 'Davao del Sur', 'Region XI', '8002', 0, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(15, 6, 'present', 'Door 2, Acacia Residences', 'Bajada', 'Davao City', 'Davao del Sur', 'Region XI', '8000', 1, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(16, 6, 'permanent', 'Purok Mangga', 'Sto. Niño', 'Panabo City', 'Davao del Norte', 'Region XI', '8105', 0, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(17, 7, 'present', '14 Palm Drive', 'Matina', 'Davao City', 'Davao del Sur', 'Region XI', '8000', 1, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(18, 7, 'permanent', '14 Palm Drive', 'Matina', 'Davao City', 'Davao del Sur', 'Region XI', '8000', 0, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(19, 8, 'present', 'Purok 2', 'Central', 'Mati City', 'Davao Oriental', 'Region XI', '8200', 1, '2026-10-19 12:02:42', '2026-10-19 12:02:42'),
(20, 8, 'permanent', 'Purok 2', 'Central', 'Mati City', 'Davao Oriental', 'Region XI', '8200', 0, '2026-10-19 12:02:42', '2026-10-19 12:02:42');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `suffix` varchar(15) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
  `civil_status` varchar(50) DEFAULT 'Single',
  `nationality` varchar(50) DEFAULT 'Filipino',
  `religion` varchar(50) DEFAULT NULL,
  `personal_email` varchar(100) DEFAULT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id`, `user_id`, `first_name`, `middle_name`, `last_name`, `suffix`, `sex`, `birthdate`, `place_of_birth`, `civil_status`, `nationality`, `religion`, `personal_email`, `contact_number`, `photo_path`, `updated_at`) VALUES
(1, 2, 'Joshua', 'Manuel', 'Pearce', '', 'Male', '2003-05-14', 'Davao City', 'Single', 'Filipino', 'Roman Catholic', 'joshua.p@gmail.com', '+63 947 882 1094', NULL, '2026-10-19 12:16:03'),
(3, 5, 'Paolo', 'R.', 'Reyes', '', 'Male', '2004-11-20', 'Digos City', 'Single', 'Filipino', 'Christian', 'paolo.reyes@yahoo.com', '+63 919 443 8912', NULL, '2026-10-19 12:02:10'),
(4, 6, 'Ana', 'C.', 'Flores', '', 'Female', '2003-09-08', 'Panabo City', 'Single', 'Filipino', 'Roman Catholic', 'ana.flores@outlook.com', '+63 928 331 4455', NULL, '2026-10-19 12:02:10'),
(5, 7, 'Mark', 'T.', 'Lim', '', 'Male', '2002-01-25', 'Davao City', 'Single', 'Filipino', 'Seventh-day Adventist', 'mark.lim@gmail.com', '+63 915 672 8841', NULL, '2026-10-19 12:02:11'),
(6, 8, 'Lea', 'B.', 'Ramos', '', 'Female', '2004-03-18', 'Mati City', 'Single', 'Filipino', 'Roman Catholic', 'lea.ramos@gmail.com', '+63 939 772 1088', NULL, '2026-10-19 12:02:11'),
(7, 1, 'Registrar', '', 'Admin', '', 'Female', '1985-10-12', 'Davao City', 'Married', 'Filipino', 'Roman Catholic', 'registrar.admin@usep.edu.ph', '+63 917 880 0024', NULL, '2026-10-19 12:02:11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_terms`
--
ALTER TABLE `academic_terms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_term_active` (`is_active`),
  ADD KEY `idx_term_dates` (`start_date`,`end_date`);

--
-- Indexes for table `academic_transactions`
--
ALTER TABLE `academic_transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_academic_transactions_docket` (`docket_no`),
  ADD KEY `idx_acad_tx_module_status` (`module`,`status`),
  ADD KEY `idx_acad_tx_student` (`student_id`),
  ADD KEY `fk_acad_tx_evaluator` (`evaluated_by`);

--
-- Indexes for table `academic_transaction_history`
--
ALTER TABLE `academic_transaction_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tx_hist_tx_id` (`transaction_id`),
  ADD KEY `idx_tx_hist_changed_by` (`changed_by`);

--
-- Indexes for table `adddrop_documents`
--
ALTER TABLE `adddrop_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_req` (`request_id`);

--
-- Indexes for table `adddrop_endorsements`
--
ALTER TABLE `adddrop_endorsements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_endorse_req` (`request_id`);

--
-- Indexes for table `adddrop_items`
--
ALTER TABLE `adddrop_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `idx_item_req` (`request_id`),
  ADD KEY `idx_item_action` (`action`);

--
-- Indexes for table `adddrop_requests`
--
ALTER TABLE `adddrop_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_no` (`reference_no`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `decided_by` (`decided_by`),
  ADD KEY `idx_adddrop_status` (`status`),
  ADD KEY `idx_adddrop_student` (`student_id`),
  ADD KEY `idx_adddrop_ref` (`reference_no`);

--
-- Indexes for table `adddrop_status_history`
--
ALTER TABLE `adddrop_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `changed_by` (`changed_by`),
  ADD KEY `idx_history_req` (`request_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `idx_sec_code` (`section_code`),
  ADD KEY `idx_sec_schedule` (`days`,`start_time`,`end_time`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_colleges_code` (`code`);

--
-- Indexes for table `correction_categories`
--
ALTER TABLE `correction_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `correction_documents`
--
ALTER TABLE `correction_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_request` (`request_id`);

--
-- Indexes for table `correction_requests`
--
ALTER TABLE `correction_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tracking_code` (`tracking_code`),
  ADD KEY `idx_student_id` (`student_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `fk_cr_category` (`category_id`),
  ADD KEY `fk_cr_reviewer` (`reviewed_by`);

--
-- Indexes for table `correction_status_history`
--
ALTER TABLE `correction_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_history_request` (`request_id`),
  ADD KEY `fk_csh_user` (`changed_by`);

--
-- Indexes for table `credit_evaluations`
--
ALTER TABLE `credit_evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ce_req` (`request_id`),
  ADD KEY `idx_ce_target` (`target_subject_id`),
  ADD KEY `fk_ce_evaluator` (`evaluator_id`);

--
-- Indexes for table `curricula`
--
ALTER TABLE `curricula`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_curricula_program` (`program_id`);

--
-- Indexes for table `curriculum_requirements`
--
ALTER TABLE `curriculum_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_curric_req` (`curriculum_id`);

--
-- Indexes for table `deficiency_notices`
--
ALTER TABLE `deficiency_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dn_req` (`request_id`),
  ADD KEY `idx_dn_student` (`student_id`),
  ADD KEY `fk_dn_issuer` (`issued_by`);

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_student_section_term` (`student_id`,`section_id`,`term_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `idx_enrollment_lookup` (`student_id`,`term_id`,`status`);

--
-- Indexes for table `graduation_applications`
--
ALTER TABLE `graduation_applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_no` (`reference_no`),
  ADD KEY `idx_grad_app_student` (`student_id`),
  ADD KEY `idx_grad_app_batch` (`batch_id`),
  ADD KEY `idx_grad_app_status` (`status`);

--
-- Indexes for table `graduation_batches`
--
ALTER TABLE `graduation_batches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_grad_batch_term` (`term_id`);

--
-- Indexes for table `graduation_clearances`
--
ALTER TABLE `graduation_clearances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_grad_clr_app` (`application_id`);

--
-- Indexes for table `graduation_status_history`
--
ALTER TABLE `graduation_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_grad_hist_app` (`application_id`);

--
-- Indexes for table `guardians`
--
ALTER TABLE `guardians`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_guardians_user` (`user_id`);

--
-- Indexes for table `loa_clearances`
--
ALTER TABLE `loa_clearances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clr_request` (`request_id`),
  ADD KEY `idx_clr_step` (`step_no`);

--
-- Indexes for table `loa_documents`
--
ALTER TABLE `loa_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_request` (`request_id`);

--
-- Indexes for table `loa_requests`
--
ALTER TABLE `loa_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_no` (`reference_no`),
  ADD KEY `idx_loa_student` (`student_id`),
  ADD KEY `idx_loa_status` (`status`),
  ADD KEY `idx_loa_type` (`type`),
  ADD KEY `idx_loa_is_sealed` (`is_sealed`),
  ADD KEY `idx_loa_ref` (`reference_no`),
  ADD KEY `fk_loa_start_term` (`leave_start_term_id`),
  ADD KEY `fk_loa_end_term` (`leave_end_term_id`),
  ADD KEY `fk_loa_decided_by` (`decided_by`);

--
-- Indexes for table `loa_status_history`
--
ALTER TABLE `loa_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hist_request` (`request_id`),
  ADD KEY `fk_loa_hist_user` (`changed_by`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_programs_code` (`code`),
  ADD KEY `fk_programs_college` (`college_id`);

--
-- Indexes for table `record_corrections`
--
ALTER TABLE `record_corrections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tracking_code` (`tracking_code`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tracking_code` (`tracking_code`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `request_items`
--
ALTER TABLE `request_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_id` (`request_id`),
  ADD KEY `document_id` (`document_id`);

--
-- Indexes for table `shifting_clearances`
--
ALTER TABLE `shifting_clearances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clr_req` (`request_id`);

--
-- Indexes for table `shifting_documents`
--
ALTER TABLE `shifting_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_req` (`request_id`),
  ADD KEY `fk_sdoc_user` (`uploaded_by`);

--
-- Indexes for table `shifting_requests`
--
ALTER TABLE `shifting_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_no` (`reference_no`),
  ADD KEY `idx_shift_student` (`student_id`),
  ADD KEY `idx_shift_status` (`status`),
  ADD KEY `idx_shift_type` (`type`),
  ADD KEY `idx_shift_to_program` (`to_program_id`),
  ADD KEY `fk_shift_from_prog` (`from_program_id`),
  ADD KEY `fk_shift_decided_by` (`decided_by`);

--
-- Indexes for table `shifting_status_history`
--
ALTER TABLE `shifting_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sh_req` (`request_id`),
  ADD KEY `fk_sh_user` (`changed_by`);

--
-- Indexes for table `staff_profiles`
--
ALTER TABLE `staff_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_staff_profiles_user_id` (`user_id`),
  ADD UNIQUE KEY `uk_staff_profiles_employee_no` (`employee_no`);

--
-- Indexes for table `student_credits`
--
ALTER TABLE `student_credits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stu_credits_student` (`student_id`),
  ADD KEY `idx_stu_credits_cat` (`category`),
  ADD KEY `fk_stu_credits_term` (`term_id`);

--
-- Indexes for table `student_records`
--
ALTER TABLE `student_records`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_student_records_user_id` (`user_id`),
  ADD UNIQUE KEY `uk_student_records_student_no` (`student_no`),
  ADD KEY `fk_student_records_college` (`college_id`),
  ADD KEY `fk_student_records_program` (`program_id`),
  ADD KEY `fk_student_records_curriculum` (`curriculum_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_subject_code` (`code`),
  ADD KEY `idx_subject_college` (`college_id`);

--
-- Indexes for table `subject_prerequisites`
--
ALTER TABLE `subject_prerequisites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_subject_prereq` (`subject_id`,`prerequisite_subject_id`),
  ADD KEY `prerequisite_subject_id` (`prerequisite_subject_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `university_id` (`university_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_addresses_user` (`user_id`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_profiles_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_terms`
--
ALTER TABLE `academic_terms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `academic_transactions`
--
ALTER TABLE `academic_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `academic_transaction_history`
--
ALTER TABLE `academic_transaction_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adddrop_documents`
--
ALTER TABLE `adddrop_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `adddrop_endorsements`
--
ALTER TABLE `adddrop_endorsements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `adddrop_items`
--
ALTER TABLE `adddrop_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `adddrop_requests`
--
ALTER TABLE `adddrop_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `adddrop_status_history`
--
ALTER TABLE `adddrop_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `class_sections`
--
ALTER TABLE `class_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `correction_categories`
--
ALTER TABLE `correction_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `correction_documents`
--
ALTER TABLE `correction_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `correction_requests`
--
ALTER TABLE `correction_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `correction_status_history`
--
ALTER TABLE `correction_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `credit_evaluations`
--
ALTER TABLE `credit_evaluations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `curricula`
--
ALTER TABLE `curricula`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `curriculum_requirements`
--
ALTER TABLE `curriculum_requirements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `deficiency_notices`
--
ALTER TABLE `deficiency_notices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `graduation_applications`
--
ALTER TABLE `graduation_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `graduation_batches`
--
ALTER TABLE `graduation_batches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `graduation_clearances`
--
ALTER TABLE `graduation_clearances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `graduation_status_history`
--
ALTER TABLE `graduation_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `guardians`
--
ALTER TABLE `guardians`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `loa_clearances`
--
ALTER TABLE `loa_clearances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `loa_documents`
--
ALTER TABLE `loa_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loa_requests`
--
ALTER TABLE `loa_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loa_status_history`
--
ALTER TABLE `loa_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `record_corrections`
--
ALTER TABLE `record_corrections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `request_items`
--
ALTER TABLE `request_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `shifting_clearances`
--
ALTER TABLE `shifting_clearances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `shifting_documents`
--
ALTER TABLE `shifting_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shifting_requests`
--
ALTER TABLE `shifting_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shifting_status_history`
--
ALTER TABLE `shifting_status_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `staff_profiles`
--
ALTER TABLE `staff_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_credits`
--
ALTER TABLE `student_credits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `student_records`
--
ALTER TABLE `student_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `subject_prerequisites`
--
ALTER TABLE `subject_prerequisites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `academic_transactions`
--
ALTER TABLE `academic_transactions`
  ADD CONSTRAINT `fk_acad_tx_evaluator` FOREIGN KEY (`evaluated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_acad_tx_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `academic_transaction_history`
--
ALTER TABLE `academic_transaction_history`
  ADD CONSTRAINT `fk_tx_hist_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `academic_transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tx_hist_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `adddrop_documents`
--
ALTER TABLE `adddrop_documents`
  ADD CONSTRAINT `adddrop_documents_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `adddrop_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `adddrop_endorsements`
--
ALTER TABLE `adddrop_endorsements`
  ADD CONSTRAINT `adddrop_endorsements_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `adddrop_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `adddrop_items`
--
ALTER TABLE `adddrop_items`
  ADD CONSTRAINT `adddrop_items_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `adddrop_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `adddrop_items_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `adddrop_requests`
--
ALTER TABLE `adddrop_requests`
  ADD CONSTRAINT `adddrop_requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `adddrop_requests_ibfk_2` FOREIGN KEY (`term_id`) REFERENCES `academic_terms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `adddrop_requests_ibfk_3` FOREIGN KEY (`decided_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `adddrop_status_history`
--
ALTER TABLE `adddrop_status_history`
  ADD CONSTRAINT `adddrop_status_history_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `adddrop_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `adddrop_status_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD CONSTRAINT `class_sections_ibfk_1` FOREIGN KEY (`term_id`) REFERENCES `academic_terms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `class_sections_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `correction_documents`
--
ALTER TABLE `correction_documents`
  ADD CONSTRAINT `fk_cd_request` FOREIGN KEY (`request_id`) REFERENCES `correction_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `correction_requests`
--
ALTER TABLE `correction_requests`
  ADD CONSTRAINT `fk_cr_category` FOREIGN KEY (`category_id`) REFERENCES `correction_categories` (`id`),
  ADD CONSTRAINT `fk_cr_reviewer` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cr_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `correction_status_history`
--
ALTER TABLE `correction_status_history`
  ADD CONSTRAINT `fk_csh_request` FOREIGN KEY (`request_id`) REFERENCES `correction_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_csh_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `credit_evaluations`
--
ALTER TABLE `credit_evaluations`
  ADD CONSTRAINT `fk_ce_evaluator` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ce_req` FOREIGN KEY (`request_id`) REFERENCES `shifting_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ce_target` FOREIGN KEY (`target_subject_id`) REFERENCES `subjects` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `curricula`
--
ALTER TABLE `curricula`
  ADD CONSTRAINT `fk_curricula_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`);

--
-- Constraints for table `curriculum_requirements`
--
ALTER TABLE `curriculum_requirements`
  ADD CONSTRAINT `fk_curric_req_curr` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deficiency_notices`
--
ALTER TABLE `deficiency_notices`
  ADD CONSTRAINT `fk_dn_issuer` FOREIGN KEY (`issued_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_dn_req` FOREIGN KEY (`request_id`) REFERENCES `shifting_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dn_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_3` FOREIGN KEY (`term_id`) REFERENCES `academic_terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `graduation_applications`
--
ALTER TABLE `graduation_applications`
  ADD CONSTRAINT `fk_grad_app_batch` FOREIGN KEY (`batch_id`) REFERENCES `graduation_batches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_grad_app_student` FOREIGN KEY (`student_id`) REFERENCES `student_records` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `graduation_batches`
--
ALTER TABLE `graduation_batches`
  ADD CONSTRAINT `fk_grad_batch_term` FOREIGN KEY (`term_id`) REFERENCES `academic_terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `graduation_clearances`
--
ALTER TABLE `graduation_clearances`
  ADD CONSTRAINT `fk_grad_clr_app` FOREIGN KEY (`application_id`) REFERENCES `graduation_applications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `graduation_status_history`
--
ALTER TABLE `graduation_status_history`
  ADD CONSTRAINT `fk_grad_hist_app` FOREIGN KEY (`application_id`) REFERENCES `graduation_applications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guardians`
--
ALTER TABLE `guardians`
  ADD CONSTRAINT `fk_guardians_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loa_clearances`
--
ALTER TABLE `loa_clearances`
  ADD CONSTRAINT `fk_loa_clr_request` FOREIGN KEY (`request_id`) REFERENCES `loa_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loa_documents`
--
ALTER TABLE `loa_documents`
  ADD CONSTRAINT `fk_loa_doc_request` FOREIGN KEY (`request_id`) REFERENCES `loa_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loa_requests`
--
ALTER TABLE `loa_requests`
  ADD CONSTRAINT `fk_loa_decided_by` FOREIGN KEY (`decided_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_loa_end_term` FOREIGN KEY (`leave_end_term_id`) REFERENCES `academic_terms` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_loa_start_term` FOREIGN KEY (`leave_start_term_id`) REFERENCES `academic_terms` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_loa_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loa_status_history`
--
ALTER TABLE `loa_status_history`
  ADD CONSTRAINT `fk_loa_hist_request` FOREIGN KEY (`request_id`) REFERENCES `loa_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_loa_hist_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `programs`
--
ALTER TABLE `programs`
  ADD CONSTRAINT `fk_programs_college` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`);

--
-- Constraints for table `record_corrections`
--
ALTER TABLE `record_corrections`
  ADD CONSTRAINT `record_corrections_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `request_items`
--
ALTER TABLE `request_items`
  ADD CONSTRAINT `request_items_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `request_items_ibfk_2` FOREIGN KEY (`document_id`) REFERENCES `document_types` (`id`);

--
-- Constraints for table `shifting_clearances`
--
ALTER TABLE `shifting_clearances`
  ADD CONSTRAINT `fk_clr_req` FOREIGN KEY (`request_id`) REFERENCES `shifting_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shifting_documents`
--
ALTER TABLE `shifting_documents`
  ADD CONSTRAINT `fk_sdoc_req` FOREIGN KEY (`request_id`) REFERENCES `shifting_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sdoc_user` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `shifting_requests`
--
ALTER TABLE `shifting_requests`
  ADD CONSTRAINT `fk_shift_decided_by` FOREIGN KEY (`decided_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_shift_from_prog` FOREIGN KEY (`from_program_id`) REFERENCES `programs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_shift_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_shift_to_prog` FOREIGN KEY (`to_program_id`) REFERENCES `programs` (`id`);

--
-- Constraints for table `shifting_status_history`
--
ALTER TABLE `shifting_status_history`
  ADD CONSTRAINT `fk_sh_req` FOREIGN KEY (`request_id`) REFERENCES `shifting_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sh_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `staff_profiles`
--
ALTER TABLE `staff_profiles`
  ADD CONSTRAINT `fk_staff_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_credits`
--
ALTER TABLE `student_credits`
  ADD CONSTRAINT `fk_stu_credits_student` FOREIGN KEY (`student_id`) REFERENCES `student_records` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_stu_credits_term` FOREIGN KEY (`term_id`) REFERENCES `academic_terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_records`
--
ALTER TABLE `student_records`
  ADD CONSTRAINT `fk_student_records_college` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_records_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_records_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_records_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`college_id`) REFERENCES `colleges` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `subject_prerequisites`
--
ALTER TABLE `subject_prerequisites`
  ADD CONSTRAINT `subject_prerequisites_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subject_prerequisites_ibfk_2` FOREIGN KEY (`prerequisite_subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `fk_user_addresses_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `fk_user_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
