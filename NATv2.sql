/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_nhs_asset_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `Dept_ID` int(3) NOT NULL,
  `Name` varchar(15) NOT NULL,
  `Floor` varchar(2),
  `Ward` varchar(3) NOT NULL,
  `Hospital_ID` int(10) NOT NULL UNIQUE,
 PRIMARY KEY (Dept_ID),
 FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID))
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Equipment`
--

CREATE TABLE `Equipment` (
  `ID` varchar(15) NOT NULL,
  `Barcode` varchar(12) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Category` varchar(25) NOT NULL,
  `Latittude` decimal(10,7) NOT NULL,
  `Longitude` decimal(10,7) NOT NULL,
  `Ping_Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Loaned` DATETIME CHECK (Loaned LIKE '--/--/----'),
  `Loaned_to` int( ),
  `Return_due` DATETIME CHECK (Return_due LIKE '--/--/----'),
  `Dept_ID` varchar( ) NOT NULL,
  `Last_Cleaned` DATETIME CHECK (Last_Cleaned LIKE '--/--/----')
 PRIMARY KEY (ID),
 FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
 FOREIGN KEY (Last_Cleaned) REFERENCES Maintenance(Cleaning_record),
 FOREIGN KEY (Loaned_to) REFERENCES Person(Pats_ID))
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Hospital`
--

CREATE TABLE `Hospital` (
  `Hosp_ID` int(10) NOT NULL,
  `Hospital_ID` varchar(10) NOT NULL UNIQUE,
  `Name` varchar(20) NOT NULL,
  `Address` varchar(35) NOT NULL,
  `Town` varchar(15) DEFAULT NULL,
  `County` varchar(30) NOT NULL,
 PRIMARY KEY (Hosp_ID))
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `IDs`
--

CREATE TABLE `IDs` (
  `Patient_ID` varchar(10) NOT NULL,
  `Staff_ID` varchar(10) NOT NULL,
  `User_Password` varchar(20) NOT NULL UNIQUE,
 PRIMARY KEY (Patient_ID),
 FOREIGN KEY (User_Password) REFERENCES User(Password)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Maintenance`
--

CREATE TABLE `Maintenance` (
  `Issue #` varchar(2) NOT NULL AUTO INCREMENT,
  `Details` varchar(60) NOT NULL,
  `Cleaning_Record` DATETIME CHECK (Cleaning_Record  LIKE '--/--/----')
  `Site` int( ) NOT NULL,
 FOREIGN KEY (Site) REFERENCES Hospital(Hosp_ID))
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Person`
--

CREATE TABLE `Person` (
  `Pats_ID` int(10) NOT NULL,
  `Surname` varchar(15) NOT NULL,
  `First_Name` varchar(15) NOT NULL,
  `Address` varchar(25) NOT NULL,
  `Town` varchar(15) DEFAULT NULL,
  `County` varchar(30) NOT NULL,
 PRIMARY KEY (Pats_ID))
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `Username` varchar(15) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `IDs_Patient_ID` varchar(10) DEFAULT AUTO INCREMENT,
  `IDs_Staff_ID` varchar(10) CHECK ((Staff_ID) IN (IDs)),
  PRIMARY KEY (Password),
  FOREIGN KEY (IDs_Patient_ID) REFERENCES (IDs),
  FOREIGN KEY (IDs_Staff_ID) REFERENCES (IDs))
  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
