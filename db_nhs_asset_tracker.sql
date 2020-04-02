-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2020 at 01:15 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_nhs_asset_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Dept_ID` int(3) NOT NULL,
  `Name` varchar(15) NOT NULL,
  `Floor` varchar(2) NOT NULL,
  `Ward` varchar(3) NOT NULL,
  `Hosp_ID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `Equip_ID` varchar(15) NOT NULL,
  `Equi_Barcode` varchar(12) NOT NULL,
  `Equi_Name` varchar(20) NOT NULL,
  `Equi_Category` varchar(12) NOT NULL,
  `Equi_Latittude` decimal(10,7) NOT NULL,
  `Equi_Longitude` decimal(10,0) DEFAULT NULL,
  `Equi_Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Equi_Pers` int(10) DEFAULT NULL,
  `Equi_Loaned` datetime DEFAULT NULL,
  `Equi_Return_Due` datetime DEFAULT NULL,
  `Equi_Dept` int(3) DEFAULT NULL,
  `Equi_Main_Last_Cleaned` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
--
-- Table structure for table `Hospital`
--
CREATE TABLE `Hospital` (
  `Hosp_ID` varchar(10) NOT NULL, -- PK
  `Hosp_Name` varchar(20) NOT NULL,
  `Hosp_Address` varchar(35) NOT NULL,
  `Hosp_Town` varchar(15) NULL, -- Not essential as County is more relevant for tracking
  `Hosp_County` varchar(30) NOT NULL,
  `Hosp_Floor` varchar(2) NOT NULL, -- For Joins
  `Hosp_Ward` varchar(3) NOT NULL,
  PRIMARY KEY (`Hosp_ID`),
  KEY `Dept_Hosp` (Hosp_ID),
  CONSTRAINT `dept_hosp` FOREIGN KEY (`Hosp_ID) REFERENCES `Department` (`Dept_ID) ON UPDATE CASCADE -- For Joins  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Table structure for table `ids`
--

CREATE TABLE `ids` (
  `IDs_Patient` int(10) NOT NULL,
  `IDs_Staff` varchar(10) NOT NULL,
  `IDs_Inpatient` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE `maintenance` (
  `Issue #` varchar(2) NOT NULL,
  `Details` varchar(60) NOT NULL,
  `Cleaning_Record` datetime NOT NULL,
  `Hosp_ID` varchar(10) NOT NULL,
  `Main_Last_Cleaned` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `Pers_Surname` varchar(15) NOT NULL,
  `Pers_Forename` varchar(15) NOT NULL,
  `Pers_Address` varchar(25) NOT NULL,
  `Pers_Town` varchar(15) DEFAULT NULL,
  `Pers_County` varchar(30) NOT NULL,
  `IDs_Patient` int(10) NOT NULL,
  `IDs_Staff` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Username` varchar(15) NOT NULL,
  `User_Pass` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Dept_ID`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`Equip_ID`),
  ADD UNIQUE KEY `Equi_Main_Last_Cleaned_2` (`Equi_Main_Last_Cleaned`),
  ADD KEY `Equi_Dept` (`Equi_Dept`),
  ADD KEY `Equi_Main_Last_Cleaned` (`Equi_Main_Last_Cleaned`),
  ADD KEY `Equi_Pers` (`Equi_Pers`) USING BTREE;

--
-- Indexes for table `ids`
--
ALTER TABLE `ids`
  ADD PRIMARY KEY (`IDs_Staff`),
  ADD UNIQUE KEY `IDs_Patient` (`IDs_Patient`,`IDs_Inpatient`) USING BTREE;

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`Cleaning_Record`),
  ADD UNIQUE KEY `Hosp_ID` (`Hosp_ID`) USING BTREE,
  ADD UNIQUE KEY `Main_Last_Cleaned` (`Main_Last_Cleaned`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`IDs_Patient`),
  ADD UNIQUE KEY `IDs_Staff` (`IDs_Staff`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `User_Pass` (`User_Pass`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `dept_hosp` FOREIGN KEY (`Hosp_ID`) REFERENCES `hospital` (`Hospital_ID`) ON UPDATE CASCADE;

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `Equi_Dept` FOREIGN KEY (`Equi_Dept`) REFERENCES `department` (`Dept_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `equi_Main` FOREIGN KEY (`Equi_Main_Last_Cleaned`) REFERENCES `maintenance` (`Main_Last_Cleaned`) ON UPDATE CASCADE,
  ADD CONSTRAINT `equi_pers` FOREIGN KEY (`Equi_Pers`) REFERENCES `person` (`IDs_Patient`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
