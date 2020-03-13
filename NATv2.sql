-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2020 at 04:06 PM
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
  `PK_Dept_ID` int(3) NOT NULL,
  `Name` varchar(15) NOT NULL,
  `FLOOR` varchar(2) NOT NULL,
  `Ward` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`PK_Dept_ID`, `Name`, `FLOOR`, `Ward`) VALUES
(1, 'A & E', '0', '001');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `PK_ID` varchar(15) NOT NULL,
  `Barcode` varchar(12) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Category` varchar(25) NOT NULL,
  `Latittude` decimal(10,7) NOT NULL,
  `Longitude` decimal(10,7) NOT NULL,
  `Ping_Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Loaned` datetime DEFAULT NULL,
  `Return_due` datetime DEFAULT NULL,
  `Last_Cleaned` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE `hospital` (
  `PK_Hosp_ID` int(10) NOT NULL,
  `UN_Hospital_ID` varchar(10) NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `Address` varchar(35) NOT NULL,
  `Town` varchar(15) DEFAULT NULL,
  `County` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hospital`
--

INSERT INTO `hospital` (`PK_Hosp_ID`, `UN_Hospital_ID`, `NAME`, `Address`, `Town`, `County`) VALUES
(1000000001, 'WLV01', 'New_Cross', '`Wolverhampton_Rd, WV10_0QP`', 'Wolverhampton', 'West_Midlands');

-- --------------------------------------------------------

--
-- Table structure for table `ids`
--

CREATE TABLE `ids` (
  `Patient_ID` varchar(10) NOT NULL,
  `Staff_ID` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE `maintenance` (
  `Issue #` varchar(2) NOT NULL,
  `Details` varchar(60) NOT NULL,
  `Cleaning_Record` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `PK_Pats_ID` int(10) NOT NULL,
  `Surname` varchar(15) NOT NULL,
  `First_Name` varchar(15) NOT NULL,
  `Address` varchar(25) NOT NULL,
  `Town` varchar(15) DEFAULT NULL,
  `County` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Username` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`PK_Dept_ID`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`PK_ID`);

--
-- Indexes for table `hospital`
--
ALTER TABLE `hospital`
  ADD PRIMARY KEY (`PK_Hosp_ID`),
  ADD UNIQUE KEY `UN_Hospital_ID` (`UN_Hospital_ID`);

--
-- Indexes for table `ids`
--
ALTER TABLE `ids`
  ADD PRIMARY KEY (`Staff_ID`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`PK_Pats_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
