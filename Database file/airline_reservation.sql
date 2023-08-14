
-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2022 at 06:18 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline_reservation`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`Harry`@`localhost` PROCEDURE `GetFlightStatistics` (IN `j_date` DATE)   BEGIN
 select flight_no,departure_date,IFNULL(no_of_passengers, 0) as no_of_passengers,total_capacity from (
select f.flight_no,f.departure_date,sum(t.no_of_passengers) as no_of_passengers,j.total_capacity 
from flight_details f left join ticket_details t 
on t.booking_status='CONFIRMED' 
and t.flight_no=f.flight_no 
and f.departure_date=t.journey_date 
inner join jet_details j on j.jet_id=f.jet_id
group by flight_no,journey_date) k where departure_date=j_date;
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` varchar(20) NOT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `staff_id` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `pwd`, `staff_id`, `name`, `email`) VALUES
('Fatema', '6172', 'admin', 'Fatema Akter Rimi', 'fatema@gmail.com'),
('Ridwan', '6172', 'admin', 'Md Ridwan', 'mdridwan@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` varchar(20) NOT NULL,
  `pwd` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `address` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `pwd`, `name`, `email`, `phone_no`, `address`) VALUES
('A', '44', 'A', 'a@gmail.com', '993498570', 'Khulna'),
('Charles', 'charles_pass', 'Charles', 'charles@gmail.com', '9090909090', 'Rajshahi'),
('Fatema', '123456', 'Fatema Akter Rimi', 'f@gmail.com', '1234569870', 'Barishal'),
('Karim', '1235', 'karim', 'hk@gmail.com', '9845713736', 'Jessore'),
('mdridwan112', '2131', 'Md Ridwan', 'tuy@gmail.com', '324324013', 'Dhaka'),
('Mohammad', '1234', 'M', 'm@gmail.com', '8080808080', 'Noakhali'),
('Rahim', '1221', 'Rahim', 'rahim@gmail.com', '12345', 'Dhaka'),
('Ridwan', '1234', 'Md Ridwan', 'mdridwan@gmail.com', '4351', 'Dhaka'),
('Rimi', '2121', 'Rimi', 'gmail@gmail.com', '5564764', 'Dhaka'),
('Rimi Fatema', '1234', 'Rimi Fatema', 'rimi@gmail.com', '12345678', 'Dhaka'),
('Saiful', '123456789', 'S', 'Sk@GMAIL.COM', '1234567890', 'Tangail');

-- --------------------------------------------------------

--
-- Table structure for table `flight_details`
--

CREATE TABLE `flight_details` (
  `flight_no` varchar(10) NOT NULL,
  `from_city` varchar(20) DEFAULT NULL,
  `to_city` varchar(20) DEFAULT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `seats_economy` int(5) DEFAULT NULL,
  `seats_business` int(5) DEFAULT NULL,
  `price_economy` int(10) DEFAULT NULL,
  `price_business` int(10) DEFAULT NULL,
  `jet_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `flight_details`
--

INSERT INTO `flight_details` (`flight_no`, `from_city`, `to_city`, `departure_date`, `arrival_date`, `departure_time`, `arrival_time`, `seats_economy`, `seats_business`, `price_economy`, `price_business`, `jet_id`) VALUES
('A123123', 'Dhaka', 'Singapore', '2022-08-01', '2022-08-02', '17:21:00', '07:26:00', 247, 50, 100000, 120000, '123123'),
('A1234', 'Dhaka', 'Delhi', '2022-08-01', '2022-08-01', '14:19:00', '19:24:00', 250, 50, 10000, 15000, '123456'),
('A31091', 'Dhaka', 'Canada', '2022-07-30', '2022-08-01', '03:43:00', '05:49:00', 400, 99, 20000, 29956, '105100'),
('A3121', 'Dhaka', 'Delhi', '2022-07-26', '2022-07-26', '23:36:00', '26:36:00', 150, 100, 8000, 12000, '105105'),
('A3122', 'Dhaka', 'Singapore', '2022-07-28', '2022-07-29', '00:37:00', '13:38:00', 197, 200, 20000, 30000, '105102'),
('AA101', 'Dhaka', 'New York', '2022-10-11', '2022-10-13', '21:00:00', '01:00:00', 195, 96, 100000, 130000, '105100'),
('B1234', 'Dhaka', 'Delhi', '2022-08-16', '2022-08-16', '11:21:00', '15:25:00', 300, 198, 10000, 15000, '000111'),
('B6719', 'Dhaka', 'Canada', '2022-07-31', '2022-08-03', '10:49:00', '13:52:00', 300, 200, 100000, 150000, '209102'),
('B6720', 'Dhaka', 'Singapore', '2022-08-06', '2022-09-07', '10:50:00', '22:50:00', 300, 199, 80000, 90000, '209102');

-- --------------------------------------------------------

--
-- Table structure for table `frequent_flier_details`
--

CREATE TABLE `frequent_flier_details` (
  `frequent_flier_no` varchar(20) NOT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `mileage` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `frequent_flier_details`
--

INSERT INTO `frequent_flier_details` (`frequent_flier_no`, `customer_id`, `mileage`) VALUES
('10001000', 'Rahim', 375),
('20002000', 'Karim', 150);

-- --------------------------------------------------------

--
-- Table structure for table `jet_details`
--

CREATE TABLE `jet_details` (
  `jet_id` varchar(10) NOT NULL,
  `jet_type` varchar(20) DEFAULT NULL,
  `total_capacity` int(5) DEFAULT NULL,
  `active` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jet_details`
--

INSERT INTO `jet_details` (`jet_id`, `jet_type`, `total_capacity`, `active`) VALUES
('000111', 'Boeing 737', 500, 'Yes'),
('10001', 'Dreamliner', 300, 'Yes'),
('10002', 'Airbus A380', 275, 'Yes'),
('10003', 'ATR', 50, 'Yes'),
('10004', 'Boeing 737', 225, 'Yes'),
('10007', 'Test_Model', 250, 'Yes'),
('105100', 'Boeing 737', 500, 'Yes'),
('105102', 'Airbus A380', 300, 'Yes'),
('105105', 'Airbus A380', 250, 'Yes'),
('123123', 'Airbus A380', 300, 'Yes'),
('123456', 'Airbus A380', 300, 'Yes'),
('209102', 'Boeing 737', 500, 'Yes'),
('AIR707MAX', 'AIRBUS 707 MX', 400, 'Yes'),
('AIRBUS69', 'AIRBUS69-5526', 780, 'Yes'),
('AIRBUS70', 'AIRBUS69-5527', 654, 'Yes'),
('AIRBUS707', 'AIRBUS69-5527', 655, 'Yes'),
('AIRBUS707M', '707 MAX', 596, 'Yes'),
('BOING707', 'BOING707-5569', 485, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `passenger_id` int(10) NOT NULL,
  `pnr` varchar(15) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `gender` varchar(8) DEFAULT NULL,
  `meal_choice` varchar(5) DEFAULT NULL,
  `frequent_flier_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`passenger_id`, `pnr`, `name`, `age`, `gender`, `meal_choice`, `frequent_flier_no`) VALUES
(1, '1089458', 'Saiful', 35, 'male', 'yes', NULL),
(1, '1574498', 'Rahim', 40, 'male', 'yes', NULL),
(1, '3567211', 'Fatema', 23, 'female', 'yes', NULL),
(1, '3569762', 'Fatema', 25, 'female', 'yes', NULL),
(1, '7030641', 'Ridwan', 23, 'male', 'yes', NULL),
(1, '8229347', 'Ridwan', 21, 'male', 'yes', NULL),
(1, '9000130', 'Md Ridwan', 24, 'male', 'yes', NULL),
(1, '9185708', 'Fatema', 23, 'female', 'yes', NULL),
(1, '9269091', 'Rahim', 40, 'male', 'yes', NULL),
(1, '9425587', 'Ridwan', 21, 'male', 'yes', NULL),
(2, '1089458', 'Sadia', 23, 'female', 'yes', NULL),
(2, '3569762', 'Nameera', 5, 'female', 'yes', NULL),
(2, '7030641', 'Ridwan', 24, 'male', 'yes', NULL),
(2, '8229347', 'f', 21, 'male', 'yes', NULL),
(2, '9185708', 'Ridwan', 23, 'male', 'yes', NULL),
(2, '9425587', 'f', 21, 'male', 'yes', NULL),
(3, '1089458', 'Samim', 20, 'male', 'yes', NULL),
(3, '9185708', 'Md', 20, 'male', 'yes', NULL),
(4, '9185708', 'Rimi', 22, 'female', 'yes', NULL),
(5, '9185708', 'Mohammed', 11, 'male', 'yes', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `payment_id` varchar(20) NOT NULL,
  `pnr` varchar(15) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_amount` int(6) DEFAULT NULL,
  `payment_mode` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`payment_id`, `pnr`, `payment_date`, `payment_amount`, `payment_mode`) VALUES
('199749959', '1089458', '2022-07-31', 302550, 'net banking'),
('437716898', '7030641', '2022-07-26', 41700, 'net banking'),
('541318486', '3567211', '2022-07-26', 20850, 'debit card'),
('735979445', '8229347', '2022-07-26', 11700, 'credit card'),
('743635787', '3569762', '2022-08-15', 31700, 'credit card'),
('821411524', '1574498', '2022-07-31', 90850, 'credit card'),
('852948081', '9000130', '2022-07-26', 30806, 'credit card');

--
-- Triggers `payment_details`
--
DELIMITER $$
CREATE TRIGGER `update_ticket_after_payment` AFTER INSERT ON `payment_details` FOR EACH ROW UPDATE ticket_details
     SET booking_status='CONFIRMED', payment_id= NEW.payment_id
   WHERE pnr = NEW.pnr
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_details`
--

CREATE TABLE `ticket_details` (
  `pnr` varchar(15) NOT NULL,
  `date_of_reservation` date DEFAULT NULL,
  `flight_no` varchar(10) DEFAULT NULL,
  `journey_date` date DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `booking_status` varchar(20) DEFAULT NULL,
  `no_of_passengers` int(5) DEFAULT NULL,
  `lounge_access` varchar(5) DEFAULT NULL,
  `priority_checkin` varchar(5) DEFAULT NULL,
  `insurance` varchar(5) DEFAULT NULL,
  `payment_id` varchar(20) DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticket_details`
--

INSERT INTO `ticket_details` (`pnr`, `date_of_reservation`, `flight_no`, `journey_date`, `class`, `booking_status`, `no_of_passengers`, `lounge_access`, `priority_checkin`, `insurance`, `payment_id`, `customer_id`) VALUES
('1089458', '2022-07-31', 'A123123', '2022-08-01', 'economy', 'CONFIRMED', 3, 'yes', 'yes', 'yes', '199749959', 'Saiful'),
('1574498', '2022-07-31', 'B6720', '2022-08-06', 'business', 'CONFIRMED', 1, 'yes', 'yes', 'yes', '821411524', 'A'),
('3567211', '2022-07-26', 'A3122', '2022-07-28', 'economy', 'CONFIRMED', 1, 'yes', 'yes', 'yes', '541318486', 'mdridwan112'),
('3569762', '2022-08-15', 'B1234', '2022-08-16', 'business', 'CONFIRMED', 2, 'yes', 'yes', 'yes', '743635787', 'Rimi Fatema'),
('7030641', '2022-07-26', 'A3122', '2022-07-28', 'economy', 'CONFIRMED', 2, 'yes', 'yes', 'yes', '437716898', 'mdridwan112'),
('8229347', '2022-07-26', 'AA101', '2022-10-11', 'economy', 'CANCELED', 2, 'yes', 'yes', 'yes', '735979445', 'mdridwan112'),
('9000130', '2022-07-26', 'A31091', '2022-07-30', 'business', 'CONFIRMED', 1, 'yes', 'yes', 'yes', '852948081', 'mdridwan112'),
('9185708', '2022-07-26', NULL, '2022-07-28', 'economy', 'PENDING', 5, 'yes', 'yes', 'yes', NULL, 'mdridwan112'),
('9269091', '2022-07-31', 'B6720', '2022-08-06', 'business', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, 'A'),
('9425587', '2022-07-26', 'AA101', '2022-10-11', 'economy', 'PENDING', 2, 'yes', 'yes', 'yes', NULL, 'mdridwan112'),
('9934333', '2022-07-26', 'AA101', '2022-10-11', 'economy', 'PENDING', 2, 'yes', 'yes', 'yes', NULL, 'mdridwan112');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `flight_details`
--
ALTER TABLE `flight_details`
  ADD PRIMARY KEY (`flight_no`,`departure_date`),
  ADD KEY `jet_id` (`jet_id`);

--
-- Indexes for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
  ADD PRIMARY KEY (`frequent_flier_no`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `jet_details`
--
ALTER TABLE `jet_details`
  ADD PRIMARY KEY (`jet_id`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`passenger_id`,`pnr`),
  ADD KEY `pnr` (`pnr`),
  ADD KEY `frequent_flier_no` (`frequent_flier_no`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `pnr` (`pnr`);

--
-- Indexes for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD PRIMARY KEY (`pnr`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `journey_date` (`journey_date`),
  ADD KEY `flight_no` (`flight_no`),
  ADD KEY `flight_no_2` (`flight_no`,`journey_date`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flight_details`
--
ALTER TABLE `flight_details`
  ADD CONSTRAINT `flight_details_ibfk_1` FOREIGN KEY (`jet_id`) REFERENCES `jet_details` (`jet_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
  ADD CONSTRAINT `frequent_flier_details_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `passengers`
--
ALTER TABLE `passengers`
  ADD CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket_details` (`pnr`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `passengers_ibfk_2` FOREIGN KEY (`frequent_flier_no`) REFERENCES `frequent_flier_details` (`frequent_flier_no`) ON UPDATE CASCADE;

--
-- Constraints for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD CONSTRAINT `payment_details_ibfk_1` FOREIGN KEY (`pnr`) REFERENCES `ticket_details` (`pnr`) ON UPDATE CASCADE;

--
-- Constraints for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD CONSTRAINT `ticket_details_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ticket_details_ibfk_3` FOREIGN KEY (`flight_no`,`journey_date`) REFERENCES `flight_details` (`flight_no`, `departure_date`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
