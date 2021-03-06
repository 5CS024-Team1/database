SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
--
-- Database: `nhs_asset_tracker`
--
-- --------------------------------------------------------
--
-- Table structure for table `Department`
--
CREATE TABLE `Department` (
  `Dept_ID` int(3) NOT NULL,
  `Dept_Name` varchar(15) NOT NULL,  
  `Hosp_ID` varchar(10) NOT NULL, -- Needed for FK
  `Hosp_Floor` varchar(2) NOT NULL, -- Possibly needed for Joins
  `Hosp_Ward` varchar(3) NOT NULL -- Possibly needed for Joins
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Table structure for table `Equipment`
--
CREATE TABLE `Equipment` (
  `Equi_ID` varchar(15) NOT NULL, -- Possible Composite Key with Barcode
  `Equi_Barcode` varchar(12) NOT NULL, -- See above
  `Equi_Name` varchar(20) NOT NULL,
  `Equi_Category` varchar(25) NOT NULL,
  `Equi_Latittude` decimal(10,7) NOT NULL,
  `Equi_Longitude` decimal(10,7) NOT NULL,
  `Equi_Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Equi_Pers` int(10) NULL, -- Needed for FK 
  `Equi_Loaned` datetime DEFAULT NULL,
  `Equi_Return_due` datetime DEFAULT NULL,
  `Equi_Dept` int(3) NULL, -- Needed for FK
  `Equi_Main_Last_Cleaned` datetime DEFAULT NULL -- Needed for FK
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
  `Hosp_Ward` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Table structure for table `IDs`
--
CREATE TABLE `IDs` (
  `IDs_Patient` int(10) NOT NULL, -- Changed to int so trigger can be implemented for Staff access
  `IDs_Staff` varchar(10) NOT NULL,
  `IDs_Inpatient` int(10) NOT NULL -- constraint to check if inpatient? 
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Table structure for table `User`
--
CREATE TABLE `User` (
  `Username` varchar(15) NOT NULL,
  `User_Pass` varchar(20) NOT NULL -- Research encryption for Password storage
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Table structure for table `Maintenance`
--
CREATE TABLE `Maintenance` (
  `Issue #` varchar(2) NOT NULL,
  `Details` varchar(60) NOT NULL,
  `Cleaning_Record` datetime NOT NULL,
  `Hosp_ID` varchar(10) NOT NULL, -- Needed for FK
  `Main_Last_Cleaned` datetime DEFAULT NULL -- Needed for FK
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
--
-- Table structure for table `Person`
--
CREATE TABLE `Person` (
  `Pers_Surname` varchar(15) NOT NULL,
  `Pers_Forename` varchar(15) NOT NULL,
  `Pers_Address` varchar(25) NOT NULL,
  `Pers_Town` varchar(15) DEFAULT NULL,
  `Pers_County` varchar(30) NOT NULL,
  `IDs_Patient` int(10) NOT NULL, -- Needed for FK
  `IDs_Staff` varchar(10) NOT NULL -- Needed for FK [Constraint needed Patient or Staff Constraint]
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- --------------------------------------------------------
-- --------------------------------------------------------
--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`Dept_ID`),
  ADD KEY `Dept_Hosp` (`Hosp_ID`);
--
-- Indexes for table `Equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`Equi_ID`),
  ADD KEY `Equi_Dept` (`Equi_Dept`),
  ADD KEY `Equi_Main` (`Equi_Main_Last_Cleaned`),
  ADD KEY `Equi_Assigned_Pats_IDs` (`Equi_Assigned_Pats_IDs`);
--
-- Indexes for table `Hospital`
--
ALTER TABLE `Hospital`
  ADD PRIMARY KEY (`Hosp_ID`);
--
-- Indexes for table `IDs`
--
ALTER TABLE `IDs`
  ADD UNIQUE KEY (`IDs_Staff`),
  ADD UNIQUE KEY (`IDs_Patient`); -- Check this will work
--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`Cleaning_Record`),
  ADD UNIQUE KEY `Main_Last_Cleaned` (`Main_Last_Cleaned`),
  ADD KEY `Main_Hosp` (`Hosp_ID`);
--
-- Indexes for table `Person`
--
ALTER TABLE `Person`
  ADD UNIQUE KEY (`IDs_Staff`),
  ADD UNIQUE KEY (`IDs_Patient`); -- Check this will work
--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `User_Pass` (`User_Pass`);

-- ---------------------------------------------------------
--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `Dept_Hosp` FOREIGN KEY (`Hosp_ID`)
  REFERENCES `hospital` (`Hosp_ID`) ON UPDATE CASCADE;
--
-- Constraints for table Equipment
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `Equi_Assigned_Pats_IDs` FOREIGN KEY (`Equi_Assigned_Pats_IDs`) REFERENCES `ids` (`IDs_Patient`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Equi_Dept` FOREIGN KEY (`Equi_Dept`) REFERENCES `department` (`Dept_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Equi_Main` FOREIGN KEY (`Equi_Main_Last_Cleaned`) REFERENCES `maintenance` (`Main_Last_Cleaned`) ON UPDATE CASCADE;
--
-- Constraints for table Maintenance
--
ALTER TABLE `Maintenance`
  ADD CONSTRAINT `Main_Hosp` FOREIGN KEY (`Hosp_ID`)
  REFERENCES `Hospital` (`Hosp_ID`) ON UPDATE CASCADE;
--
-- Constraints for table Person
--
ALTER TABLE `Person`
  ADD CONSTRAINT `Pers_Pats_ID` FOREIGN KEY(`IDs_Patient`)
  REFERENCES `ids`(`IDs_Patient`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Pers_Staf_ID` FOREIGN KEY(`IDs_Staff`)
  REFERENCES `ids`(`IDs_Staff`) ON UPDATE CASCADE;
--
COMMIT;
--
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
