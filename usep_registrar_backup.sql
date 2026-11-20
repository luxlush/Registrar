-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 17, 2026 at 06:14 PM
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
(2, 'Academic Records', 'Form 137 (Permanent Record)', 100.00, 1),
(3, 'Certifications', 'Certificate of Enrollment', 50.00, 1),
(4, 'Certifications', 'Certificate of Good Moral Character', 50.00, 1),
(5, 'Certifications', 'Certificate of General Weighted Average', 50.00, 1),
(6, 'Graduation & Transfer', 'Honorable Dismissal', 100.00, 1),
(7, 'Graduation & Transfer', 'Diploma (Reprint)', 200.00, 1);

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
(18, 'DOC-2610172993', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:07:11', '2026-10-17 16:07:11'),
(19, 'DOC-2610172207', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:07:29', '2026-10-17 16:07:29'),
(20, 'DOC-2610175525', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:07:43', '2026-10-17 16:07:43'),
(21, 'DOC-2610174997', 1, 'pickup', 'online', 150.00, 'Pending Review', '2026-10-17 16:07:57', '2026-10-17 16:07:57');

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
(21, 21, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `university_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('student','admin','registrar','cashier') NOT NULL DEFAULT 'student',
  `college` varchar(100) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `university_id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `college`, `program`, `created_at`) VALUES
(1, 'REG-ADMIN-04', 'Registrar', 'Admin', 'admin@usep.edu.ph', '$2y$10$6CQ8b6gJlVHJDgxdo33oUOtwT1YKoMZ8p79SNc4vu4HHTvvZkLYYa', 'admin', NULL, NULL, '2026-10-06 12:54:12'),
(2, '2021-04182', 'Joshua', 'Pearce', 'joshua@usep.edu.ph', '$2y$10$/Koyp37hqcYtDiqSELEXq.xV.fL8OMesKRbap1FjZJw4v3nYA0IAW', 'student', 'College of Computing', 'BS Computer Science', '2026-10-06 12:54:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `university_id` (`university_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `request_items`
--
ALTER TABLE `request_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
