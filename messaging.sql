-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2020 at 04:48 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `messaging`
--

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `AttachmentID` int(12) NOT NULL,
  `ChatID` varchar(100) NOT NULL,
  `FileName` varchar(50) NOT NULL,
  `FileType` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `ChatID` varchar(100) NOT NULL,
  `SenderID` int(12) NOT NULL,
  `RecipientID` int(12) NOT NULL,
  `Messages` text NOT NULL,
  `StatusID` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `GroupID` int(12) NOT NULL,
  `GroupName` varchar(50) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `group_chats`
--

CREATE TABLE `group_chats` (
  `GroupID` int(12) NOT NULL,
  `ChatID` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `GroupID` int(12) NOT NULL,
  `UserID` int(12) NOT NULL,
  `RoleID` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `RoleID` int(1) NOT NULL,
  `RoleName` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE `statuses` (
  `StatusID` int(1) NOT NULL,
  `StatusName` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(12) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `ProfilePicture` varchar(50) DEFAULT NULL,
  `VerificationCode` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`AttachmentID`),
  ADD KEY `ChatID` (`ChatID`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`ChatID`),
  ADD KEY `SenderID` (`SenderID`),
  ADD KEY `RecipientID` (`RecipientID`),
  ADD KEY `StatusID` (`StatusID`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`GroupID`);

--
-- Indexes for table `group_chats`
--
ALTER TABLE `group_chats`
  ADD KEY `GroupID` (`GroupID`),
  ADD KEY `ChatID` (`ChatID`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD KEY `GroupID` (`GroupID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `RoleID` (`RoleID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`RoleID`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`StatusID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Phone`),
  ADD KEY `UserID` (`UserID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `FKAttachmentChat` FOREIGN KEY (`ChatID`) REFERENCES `chats` (`ChatID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `FKRecipient` FOREIGN KEY (`RecipientID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKSender` FOREIGN KEY (`SenderID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKStatus` FOREIGN KEY (`StatusID`) REFERENCES `statuses` (`StatusID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_chats`
--
ALTER TABLE `group_chats`
  ADD CONSTRAINT `FKChat` FOREIGN KEY (`ChatID`) REFERENCES `chats` (`ChatID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKGroup` FOREIGN KEY (`GroupID`) REFERENCES `groups` (`GroupID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `FKGroupMember` FOREIGN KEY (`GroupID`) REFERENCES `groups` (`GroupID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FKRole` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FKUser` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
