-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.25 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for rental_portal
CREATE DATABASE IF NOT EXISTS `rental_portal` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rental_portal`;

-- Dumping structure for table rental_portal.car
CREATE TABLE IF NOT EXISTS `car` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rental_station_id` int DEFAULT NULL,
  `car_type_id` int DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_station_id` (`rental_station_id`),
  KEY `car_type_id` (`car_type_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`rental_station_id`) REFERENCES `rental_station` (`id`),
  CONSTRAINT `car_ibfk_2` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_ibfk_3` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car: ~0 rows (approximately)
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
/*!40000 ALTER TABLE `car` ENABLE KEYS */;

-- Dumping structure for table rental_portal.car_class
CREATE TABLE IF NOT EXISTS `car_class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_class: ~0 rows (approximately)
/*!40000 ALTER TABLE `car_class` DISABLE KEYS */;
REPLACE INTO `car_class` (`id`, `name`) VALUES
	(1, 'Kleinwagen'),
	(2, 'Kompaktklasse'),
	(3, 'Mittelklasse'),
	(4, 'Oberklasse'),
	(5, 'SUV'),
	(6, 'Kombi');
/*!40000 ALTER TABLE `car_class` ENABLE KEYS */;

-- Dumping structure for table rental_portal.car_type
CREATE TABLE IF NOT EXISTS `car_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seats` int DEFAULT NULL,
  `doors` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_type: ~0 rows (approximately)
/*!40000 ALTER TABLE `car_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_type` ENABLE KEYS */;

-- Dumping structure for table rental_portal.car_type_class
CREATE TABLE IF NOT EXISTS `car_type_class` (
  `car_type_id` int DEFAULT NULL,
  `car_class_id` int DEFAULT NULL,
  KEY `car_type_id` (`car_type_id`),
  KEY `car_class_id` (`car_class_id`),
  CONSTRAINT `car_type_class_ibfk_1` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_type_class_ibfk_2` FOREIGN KEY (`car_class_id`) REFERENCES `car_class` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_type_class: ~0 rows (approximately)
/*!40000 ALTER TABLE `car_type_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_type_class` ENABLE KEYS */;

-- Dumping structure for table rental_portal.car_type_extra
CREATE TABLE IF NOT EXISTS `car_type_extra` (
  `car_type_id` int DEFAULT NULL,
  `extra_id` int DEFAULT NULL,
  KEY `car_type_id` (`car_type_id`),
  KEY `extra_id` (`extra_id`),
  CONSTRAINT `car_type_extra_ibfk_1` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_type_extra_ibfk_2` FOREIGN KEY (`extra_id`) REFERENCES `extra` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_type_extra: ~0 rows (approximately)
/*!40000 ALTER TABLE `car_type_extra` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_type_extra` ENABLE KEYS */;

-- Dumping structure for table rental_portal.car_type_feature
CREATE TABLE IF NOT EXISTS `car_type_feature` (
  `car_type_id` int DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  KEY `car_type_id` (`car_type_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `car_type_feature_ibfk_1` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_type_feature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_type_feature: ~0 rows (approximately)
/*!40000 ALTER TABLE `car_type_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_type_feature` ENABLE KEYS */;

-- Dumping structure for table rental_portal.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.customer: ~0 rows (approximately)
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- Dumping structure for table rental_portal.extra
CREATE TABLE IF NOT EXISTS `extra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.extra: ~0 rows (approximately)
/*!40000 ALTER TABLE `extra` DISABLE KEYS */;
REPLACE INTO `extra` (`id`, `name`) VALUES
	(1, 'Haftpflichtversicherung'),
	(2, 'Freikilometer 750'),
	(3, 'Freikilometer 1500'),
	(4, 'Glas & Reifenschutz');
/*!40000 ALTER TABLE `extra` ENABLE KEYS */;

-- Dumping structure for table rental_portal.feature
CREATE TABLE IF NOT EXISTS `feature` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.feature: ~0 rows (approximately)
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
REPLACE INTO `feature` (`id`, `name`) VALUES
	(1, 'Navigation'),
	(2, 'Klimaanlage'),
	(3, 'Automatik'),
	(4, 'Winterreifen');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

-- Dumping structure for table rental_portal.manufacturer
CREATE TABLE IF NOT EXISTS `manufacturer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.manufacturer: ~0 rows (approximately)
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;

-- Dumping structure for table rental_portal.rental
CREATE TABLE IF NOT EXISTS `rental` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reservation_id` int DEFAULT NULL,
  `car_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_id` (`reservation_id`),
  KEY `car_id` (`car_id`),
  CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.rental: ~0 rows (approximately)
/*!40000 ALTER TABLE `rental` DISABLE KEYS */;
/*!40000 ALTER TABLE `rental` ENABLE KEYS */;

-- Dumping structure for table rental_portal.rental_station
CREATE TABLE IF NOT EXISTS `rental_station` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.rental_station: ~0 rows (approximately)
/*!40000 ALTER TABLE `rental_station` DISABLE KEYS */;
/*!40000 ALTER TABLE `rental_station` ENABLE KEYS */;

-- Dumping structure for table rental_portal.reservation
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `car_type_id` int DEFAULT NULL,
  `reserved_at` datetime DEFAULT NULL,
  `rent_from` datetime DEFAULT NULL,
  `rent_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `car_type_id` (`car_type_id`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.reservation: ~0 rows (approximately)
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;

-- Dumping structure for table rental_portal.take_back_protocol
CREATE TABLE IF NOT EXISTS `take_back_protocol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rental_id` int DEFAULT NULL,
  `cur_kilometers` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_id` (`rental_id`),
  CONSTRAINT `take_back_protocol_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.take_back_protocol: ~0 rows (approximately)
/*!40000 ALTER TABLE `take_back_protocol` DISABLE KEYS */;
/*!40000 ALTER TABLE `take_back_protocol` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
