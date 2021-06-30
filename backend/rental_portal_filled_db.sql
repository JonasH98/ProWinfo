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
  `car_price` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_station_id` (`rental_station_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `car_type_id` (`car_type_id`) USING BTREE,
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`rental_station_id`) REFERENCES `rental_station` (`id`),
  CONSTRAINT `car_ibfk_3` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`),
  CONSTRAINT `FK_car_car_type` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car: ~24 rows (approximately)
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
REPLACE INTO `car` (`id`, `rental_station_id`, `car_type_id`, `manufacturer_id`, `image_url`, `car_price`) VALUES
	(1, 14, 1, 3, NULL, 129.99),
	(2, 15, 1, 1, NULL, 120.99),
	(3, 8, 7, 2, NULL, 80.99),
	(4, 18, 1, 4, NULL, 75.99),
	(5, 14, 6, 4, NULL, 222.99),
	(6, 13, 8, 2, NULL, 123.99),
	(7, 3, 6, 1, NULL, 129.99),
	(8, 2, 8, 3, NULL, 119.99),
	(9, 19, 2, 4, NULL, 111.99),
	(10, 9, 2, 2, NULL, 99.99),
	(11, 6, 2, 1, NULL, 95.99),
	(12, 12, 7, 3, NULL, 55.99),
	(13, 5, 3, 4, NULL, 64.99),
	(14, 3, 3, 2, NULL, 77.99),
	(15, 6, 3, 1, NULL, 120.99),
	(16, 14, 7, 3, NULL, 53.99),
	(17, 16, 4, 4, NULL, 99.99),
	(18, 1, 4, 2, NULL, 145.99),
	(19, 8, 4, 1, NULL, 177.99),
	(20, 17, 6, 3, NULL, 164.99),
	(21, 18, 5, 4, NULL, 134.99),
	(22, 1, 4, 2, NULL, 132.99),
	(23, 15, 6, 1, NULL, 91.99),
	(24, 20, 5, 3, NULL, 72.99);
/*!40000 ALTER TABLE `car` ENABLE KEYS */;

-- Dumping structure for table rental_portal.car_class
CREATE TABLE IF NOT EXISTS `car_class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_class: ~6 rows (approximately)
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
  `seats` varchar(50) DEFAULT NULL,
  `doors` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.car_type: ~8 rows (approximately)
/*!40000 ALTER TABLE `car_type` DISABLE KEYS */;
REPLACE INTO `car_type` (`id`, `seats`, `doors`) VALUES
	(1, '2-3', '2-3'),
	(2, '4-5', '2-3'),
	(3, '6-7', '2-3'),
	(4, '8-9', '2-3'),
	(5, '2-3', '4-5'),
	(6, '4-5', '4-5'),
	(7, '6-7', '4-5'),
	(8, '8-9', '4-5');
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

-- Dumping data for table rental_portal.car_type_class: ~8 rows (approximately)
/*!40000 ALTER TABLE `car_type_class` DISABLE KEYS */;
REPLACE INTO `car_type_class` (`car_type_id`, `car_class_id`) VALUES
	(1, 1),
	(2, 5),
	(3, 6),
	(4, 2),
	(5, 2),
	(6, 6),
	(7, 4),
	(8, 3);
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

-- Dumping data for table rental_portal.car_type_extra: ~19 rows (approximately)
/*!40000 ALTER TABLE `car_type_extra` DISABLE KEYS */;
REPLACE INTO `car_type_extra` (`car_type_id`, `extra_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(4, 2),
	(4, 3),
	(4, 4),
	(5, 1),
	(5, 2),
	(5, 3),
	(6, 1),
	(6, 2),
	(6, 3),
	(7, 1),
	(7, 2),
	(8, 1),
	(8, 2),
	(8, 3),
	(8, 4);
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

-- Dumping data for table rental_portal.car_type_feature: ~21 rows (approximately)
/*!40000 ALTER TABLE `car_type_feature` DISABLE KEYS */;
REPLACE INTO `car_type_feature` (`car_type_id`, `feature_id`) VALUES
	(1, 1),
	(1, 2),
	(2, 1),
	(3, 1),
	(3, 2),
	(4, 1),
	(4, 2),
	(4, 3),
	(5, 1),
	(5, 2),
	(5, 3),
	(5, 4),
	(6, 1),
	(6, 2),
	(6, 3),
	(7, 1),
	(7, 2),
	(7, 3),
	(7, 4),
	(8, 1),
	(8, 2);
/*!40000 ALTER TABLE `car_type_feature` ENABLE KEYS */;

-- Dumping structure for table rental_portal.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.customer: ~200 rows (approximately)
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
REPLACE INTO `customer` (`id`, `full_name`, `address`, `email`, `created_at`, `password`) VALUES
	(1, 'Aharon Brandts', '4090 Utah Hill', 'abrandts0@baidu.com', '2020-08-09 12:33:06', '7Cwasv'),
	(2, 'Rory Chavez', '370 Lotheville Street', 'rchavez1@wufoo.com', '2020-02-22 15:57:29', 'VOnPE0uCeG'),
	(3, 'Marcello Mateuszczyk', '3 Cordelia Alley', 'mmateuszczyk2@alibaba.com', '2017-03-19 10:13:52', 'LtJCY8jL'),
	(4, 'Thor Radbone', '76 Mesta Court', 'tradbone3@oakley.com', '2017-02-27 00:40:05', 'WZsQLMb5wA'),
	(5, 'Fey Meindl', '9413 Browning Street', 'fmeindl4@elegantthemes.com', '2017-04-17 17:57:03', 'b3iamZliy0t'),
	(6, 'Happy Dudden', '7538 Green Way', 'hdudden5@alibaba.com', '2015-08-23 19:42:38', 'BvrmbnL'),
	(7, 'Poul Bushill', '23 Express Plaza', 'pbushill6@creativecommons.org', '2018-01-05 04:15:23', 'l8xwwLD'),
	(8, 'Iseabal Wallace', '38 Wayridge Terrace', 'iwallace7@hhs.gov', '2015-03-06 22:32:13', 'mCUcWB68'),
	(9, 'Kaia MacInnes', '4408 Spenser Place', 'kmacinnes8@vimeo.com', '2019-03-17 06:22:13', '026JHO7uR'),
	(10, 'Maryjo Edie', '63 Lindbergh Pass', 'medie9@hatena.ne.jp', '2019-03-11 20:46:41', 'QuWmfFO4'),
	(11, 'Ruddie Fealy', '5938 Cardinal Center', 'rfealya@goo.gl', '2015-04-30 23:39:19', 'XTLXLWjP'),
	(12, 'Thane Bratt', '397 Harbort Terrace', 'tbrattb@google.com', '2015-03-15 01:58:51', 'CjWxAb22TJQ2'),
	(13, 'Quinta Howitt', '1 Homewood Trail', 'qhowittc@themeforest.net', '2019-07-06 21:22:08', 'Z7O6hKiAtS'),
	(14, 'Ash Freddi', '4 Westridge Pass', 'afreddid@eepurl.com', '2016-05-06 11:07:04', '4DnEoOiuc2'),
	(15, 'Mariejeanne Fruchon', '90 Novick Park', 'mfruchone@topsy.com', '2020-09-29 18:51:09', 'CEqAAgzp'),
	(16, 'Ruthanne Deetlof', '8 Gulseth Alley', 'rdeetloff@wiley.com', '2017-10-29 23:18:24', '9ISNbvCBzgR'),
	(17, 'Masha Town', '8 Center Drive', 'mtowng@163.com', '2016-09-24 03:00:01', 'COjDeQ0mA'),
	(18, 'Sophey Danit', '6618 Michigan Place', 'sdanith@vistaprint.com', '2017-03-09 01:13:27', 's1MIiakg5'),
	(19, 'Lynna Santon', '45908 Blaine Court', 'lsantoni@usnews.com', '2018-05-14 11:24:50', 'cQxCBbP2zzU'),
	(20, 'Chelsie Carlisi', '4 Springs Circle', 'ccarlisij@ovh.net', '2018-12-14 01:11:45', '0ekLq73QAQ0'),
	(21, 'Brigitta Monkhouse', '714 Caliangt Center', 'bmonkhousek@squidoo.com', '2020-04-02 10:12:14', 'MI1QO4VFT9'),
	(22, 'Kathryne Lipmann', '6305 Garrison Point', 'klipmannl@g.co', '2015-07-03 12:58:12', 'g439qb'),
	(23, 'Rolf Sullens', '0 Mcbride Way', 'rsullensm@hc360.com', '2015-05-19 15:37:52', 'ayMNCq'),
	(24, 'Gerek Beggs', '250 Jenna Crossing', 'gbeggsn@sohu.com', '2020-07-25 22:11:43', 'a3cFDsYyogZ'),
	(25, 'Mellicent Couldwell', '3043 6th Circle', 'mcouldwello@wufoo.com', '2021-01-28 23:16:18', 'ywoOW7L9ua'),
	(26, 'Dale Epsly', '6 Esker Parkway', 'depslyp@shinystat.com', '2020-08-08 08:05:17', '9Qt0VPHnFi65'),
	(27, 'Pavia Pelerin', '88 6th Junction', 'ppelerinq@mayoclinic.com', '2020-06-25 20:35:16', 'C46rquT6'),
	(28, 'Delora Rozenbaum', '67940 Toban Center', 'drozenbaumr@webnode.com', '2015-09-11 05:15:59', 'XbtPD5'),
	(29, 'Timmy Copyn', '3 Moulton Trail', 'tcopyns@lulu.com', '2018-03-30 03:50:50', 'fCpq3EWNP'),
	(30, 'Missy Pletts', '679 Grasskamp Center', 'mplettst@mapy.cz', '2020-02-17 17:34:54', 'ATdHtwL'),
	(31, 'Base Attwool', '3366 Susan Point', 'battwoolu@businesswire.com', '2016-06-14 20:16:52', '5lxXmqRMSuc'),
	(32, 'Milo Raison', '1122 Stuart Junction', 'mraisonv@twitter.com', '2020-05-25 08:44:11', 'N0pPnlaG'),
	(33, 'Marcille Jakubowsky', '7 Elgar Trail', 'mjakubowskyw@soup.io', '2018-05-18 07:41:26', 'RXlBzkF'),
	(34, 'Christa Shervington', '71453 Dwight Circle', 'cshervingtonx@latimes.com', '2020-12-12 11:16:46', 'bTarbFSk'),
	(35, 'Fremont Hegdonne', '084 Linden Center', 'fhegdonney@blogtalkradio.com', '2021-05-17 01:01:59', 'RB0SILmFGbB'),
	(36, 'Clemmy Cullerne', '6625 Muir Trail', 'ccullernez@nymag.com', '2017-03-03 00:57:29', 'Eu2wq7xcgUo'),
	(37, 'Blondell Mogg', '39 Canary Circle', 'bmogg10@ow.ly', '2016-10-21 16:56:59', '4uGdZDbW4'),
	(38, 'Deeanne Dincey', '5033 Dahle Center', 'ddincey11@bloglovin.com', '2018-09-24 04:07:57', 'FkHXO6'),
	(39, 'Bari Stickels', '4681 Sage Alley', 'bstickels12@ycombinator.com', '2014-08-20 21:34:26', 'zRXvwiBA6b'),
	(40, 'Dennet Foss', '53660 Sunfield Trail', 'dfoss13@discuz.net', '2020-03-01 07:04:39', 'NNDh0Azq'),
	(41, 'William Krier', '07 Drewry Avenue', 'wkrier14@sbwire.com', '2016-09-15 01:16:43', 'W2ktQdYSk5a'),
	(42, 'Jim Rough', '00103 Lerdahl Lane', 'jrough15@com.com', '2021-05-24 05:45:42', 'JblFASlhm49'),
	(43, 'Lorita Ollington', '52 Laurel Circle', 'lollington16@indiatimes.com', '2020-11-04 21:36:30', 'KHChF2PRgJu'),
	(44, 'Dimitry Lyne', '390 Weeping Birch Avenue', 'dlyne17@zimbio.com', '2015-07-12 14:25:49', 'pG5BshcuF'),
	(45, 'Gerrard Trasler', '3666 Pawling Junction', 'gtrasler18@yahoo.co.jp', '2017-06-14 01:00:23', 'tSpZQDOvEjhE'),
	(46, 'Reiko Avarne', '9 Welch Plaza', 'ravarne19@friendfeed.com', '2019-09-09 16:56:28', 'pOQ1MoY8b'),
	(47, 'Marni Campe', '82876 Nevada Park', 'mcampe1a@altervista.org', '2016-10-14 17:56:55', 'RjELoJHq'),
	(48, 'Rozamond Hynson', '46 Boyd Hill', 'rhynson1b@cornell.edu', '2020-08-26 09:07:41', 'CjjWZRTptrX'),
	(49, 'Jolie Labroue', '21873 Sherman Lane', 'jlabroue1c@miitbeian.gov.cn', '2014-10-22 20:18:25', 'ZUbw96ogy'),
	(50, 'Gwynne Benduhn', '47399 Oxford Place', 'gbenduhn1d@barnesandnoble.com', '2015-01-24 07:22:29', 'N6mZKt4dMQbU'),
	(51, 'Libbey Hallett', '28 Chive Trail', 'lhallett1e@4shared.com', '2019-07-21 19:18:18', 'gnJvVEdl2fz'),
	(52, 'Bethany Peepall', '65 Golf View Junction', 'bpeepall1f@usnews.com', '2015-12-09 18:04:54', 'sxdEotK6oyV'),
	(53, 'Gaston Lorenzini', '638 Lakewood Junction', 'glorenzini1g@e-recht24.de', '2021-04-14 21:25:03', '9CbBMHyXUrf'),
	(54, 'Jonas Arkil', '44 Weeping Birch Drive', 'jarkil1h@usgs.gov', '2019-05-28 10:33:22', '383L96Y26'),
	(55, 'Glynda Pruvost', '25 Laurel Crossing', 'gpruvost1i@comsenz.com', '2021-05-15 14:43:09', 'd95bu7KKl1'),
	(56, 'Brena Sampson', '465 Cordelia Point', 'bsampson1j@drupal.org', '2019-07-11 13:40:19', 'Eg8YUVd0QF'),
	(57, 'Briggs Fowls', '3967 Grim Parkway', 'bfowls1k@sfgate.com', '2017-11-28 23:44:35', 'bBGr7jj'),
	(58, 'Hobard Flack', '43 Marcy Pass', 'hflack1l@scientificamerican.com', '2019-03-11 15:47:41', 'S3S2yNMNYM1M'),
	(59, 'Rena Giddings', '0396 Chinook Road', 'rgiddings1m@google.es', '2016-12-17 07:58:21', '2QRoMYzswD2F'),
	(60, 'Kylila McMurray', '84 Corry Circle', 'kmcmurray1n@opera.com', '2019-03-18 20:55:42', '8LfF9ygbQvM'),
	(61, 'Raffarty Gerner', '58639 Mitchell Court', 'rgerner1o@last.fm', '2020-04-23 11:05:42', 'xBI9WMV8O'),
	(62, 'Ofella Radborne', '085 Nevada Hill', 'oradborne1p@nba.com', '2020-10-22 09:31:45', 'TUsB0zJ3QP0i'),
	(63, 'Der Walstow', '38654 Stang Hill', 'dwalstow1q@theatlantic.com', '2015-03-09 12:08:50', 'EIQZaAaES2'),
	(64, 'Nomi Maddie', '9876 Carioca Park', 'nmaddie1r@gnu.org', '2016-08-12 01:42:23', 'pOqeA4'),
	(65, 'Nissy Hulse', '22 Anhalt Parkway', 'nhulse1s@live.com', '2020-10-02 02:58:13', 'JmZVdUE4H9'),
	(66, 'Dane Bette', '888 Brown Lane', 'dbette1t@dedecms.com', '2020-12-16 21:31:04', 'Yqi1JeKJwR'),
	(67, 'Scotti Whitwham', '77460 New Castle Court', 'swhitwham1u@godaddy.com', '2020-06-08 11:13:00', 'Hm4b1WKxAdR'),
	(68, 'Kaia Shirley', '51 Michigan Trail', 'kshirley1v@baidu.com', '2020-11-02 02:17:04', 'bTupexi4A'),
	(69, 'Kaitlynn Rehorek', '8904 Charing Cross Plaza', 'krehorek1w@goo.ne.jp', '2016-07-23 20:07:06', 'He7Y8H'),
	(70, 'Toby Flemyng', '54 Londonderry Way', 'tflemyng1x@youtu.be', '2020-10-12 07:53:08', 'KvpjjspC'),
	(71, 'Wade Aliman', '893 Kenwood Avenue', 'waliman1y@parallels.com', '2019-03-03 07:02:53', 'MwpjI7ttpve'),
	(72, 'Selby Lewerenz', '3093 Butterfield Hill', 'slewerenz1z@mit.edu', '2018-02-12 09:07:01', '7a4laKsrKA5'),
	(73, 'Cacilia Coggen', '71819 Sachs Way', 'ccoggen20@foxnews.com', '2018-11-16 18:34:40', 'jLIAAM'),
	(74, 'Matilde Santarelli', '35 Melody Court', 'msantarelli21@rakuten.co.jp', '2018-12-09 21:54:16', 'jws0HLm'),
	(75, 'Minnnie Trenholm', '57 Derek Plaza', 'mtrenholm22@imageshack.us', '2020-03-15 03:33:06', 'd6ipgf39p'),
	(76, 'Sonja Mathelin', '4 Nova Plaza', 'smathelin23@wordpress.com', '2021-01-01 13:06:40', '3T7Hju0'),
	(77, 'Fair Abramowitch', '368 Florence Terrace', 'fabramowitch24@sakura.ne.jp', '2018-01-24 02:38:27', '51XJWe'),
	(78, 'Martica Battelle', '91800 Commercial Place', 'mbattelle25@va.gov', '2021-04-10 23:24:50', 'Yn4zpvwEDfH'),
	(79, 'Chiquia Shiel', '8 Randy Alley', 'cshiel26@comsenz.com', '2020-03-07 13:10:40', 'PSvYqLxA9qGT'),
	(80, 'Karina Mahony', '10 Forster Lane', 'kmahony27@weibo.com', '2021-01-30 02:34:14', 'dWJp802tqK'),
	(81, 'Jeth Davage', '66997 Macpherson Parkway', 'jdavage28@intel.com', '2017-12-25 17:05:12', 'U2njCbnbuIP5'),
	(82, 'Herman O\'Dea', '3074 3rd Center', 'hodea29@booking.com', '2019-06-09 08:21:46', 'CQG6weCzaIX1'),
	(83, 'Corliss Gonneau', '4838 Chinook Way', 'cgonneau2a@skype.com', '2018-01-25 20:53:51', 'D2SqLtE'),
	(84, 'Jeanelle Sankey', '87 Talmadge Road', 'jsankey2b@google.com.au', '2018-01-10 09:26:14', 'DZgQzUaKf7'),
	(85, 'Charo Schimann', '89 Forest Dale Plaza', 'cschimann2c@google.co.jp', '2020-12-14 11:17:28', 'u4dffrToh'),
	(86, 'Osbourne Davall', '2 Calypso Drive', 'odavall2d@youtu.be', '2020-09-07 06:35:24', 'tFtC5Lp'),
	(87, 'Anselma Ingles', '1 Sullivan Pass', 'aingles2e@adobe.com', '2021-06-05 05:48:08', 'WgpBhaRS9E1h'),
	(88, 'Somerset Keyho', '49 Milwaukee Crossing', 'skeyho2f@freewebs.com', '2015-08-08 21:48:37', 'XB80zk'),
	(89, 'Adolphus Mungham', '84 Haas Center', 'amungham2g@vimeo.com', '2016-09-11 10:29:11', '2BKtm0B'),
	(90, 'Jo ann Wheatman', '848 Roxbury Hill', 'jann2h@yolasite.com', '2019-11-13 17:04:50', 'ZauAbH'),
	(91, 'Tymon Chappelle', '63 Sutherland Lane', 'tchappelle2i@sfgate.com', '2015-10-04 05:11:36', 'FIKYuu'),
	(92, 'Ellery Raselles', '1358 Jay Street', 'eraselles2j@chicagotribune.com', '2016-02-17 04:35:03', 'FwpgBTufNc5'),
	(93, 'Milli Dacks', '1265 Westend Crossing', 'mdacks2k@amazon.co.uk', '2018-12-29 18:50:34', 'WCQjlD'),
	(94, 'Jennica Rasmus', '0 Sheridan Point', 'jrasmus2l@bizjournals.com', '2015-05-22 14:33:56', 'j3GgZhun1'),
	(95, 'Field Euston', '94565 Trailsway Place', 'feuston2m@vimeo.com', '2016-07-01 22:45:17', 'OwNUIlz'),
	(96, 'Tricia Meltetal', '77981 Crescent Oaks Plaza', 'tmeltetal2n@ucoz.ru', '2014-08-29 17:32:42', 'htVbknIl'),
	(97, 'Tony Akred', '2717 Eggendart Place', 'takred2o@indiegogo.com', '2020-08-21 21:29:57', 'lyZuKJ'),
	(98, 'Jeremy Preator', '20448 Ridgeway Junction', 'jpreator2p@dion.ne.jp', '2019-06-24 02:28:35', '75YfYjoheIv'),
	(99, 'Malynda Covely', '5 Hoard Alley', 'mcovely2q@bloomberg.com', '2021-04-13 19:50:00', 'tHPV6JB'),
	(100, 'Vasilis Whettleton', '9827 Fremont Road', 'vwhettleton2r@nytimes.com', '2019-01-13 15:11:11', 'q5COJviVCMO8'),
	(101, 'Merrielle Robberts', '07 Burrows Alley', 'mrobberts2s@sciencedirect.com', '2019-04-30 20:11:05', 'FzpvtZ0'),
	(102, 'Petronille Ventris', '5 Lotheville Circle', 'pventris2t@nymag.com', '2016-09-18 05:26:28', '5EygN8cXi'),
	(103, 'Kissie Neligan', '9 Reindahl Trail', 'kneligan2u@studiopress.com', '2018-04-06 04:32:24', 'UUdtLd'),
	(104, 'Carey Schwander', '6 Village Green Lane', 'cschwander2v@reverbnation.com', '2014-08-28 19:43:32', '6hlLfSkkuHk'),
	(105, 'Carney Snel', '57 Moose Plaza', 'csnel2w@oaic.gov.au', '2018-11-13 07:41:53', 'Zp8ppe'),
	(106, 'Ximenez Bindon', '9 Oakridge Drive', 'xbindon2x@state.tx.us', '2019-08-09 05:42:08', 'MUSD1VgP1Y9i'),
	(107, 'Ingra Newns', '2884 Dixon Pass', 'inewns2y@mysql.com', '2019-08-14 19:36:36', 'd5vdRVCa6pj'),
	(108, 'Ernest Baroch', '614 Vernon Way', 'ebaroch2z@ask.com', '2018-02-04 07:30:25', 'dX1pslLKyxLp'),
	(109, 'Bobinette Goosey', '77 Kings Plaza', 'bgoosey30@ask.com', '2019-06-26 09:48:22', 'JbqyMMzAAdB'),
	(110, 'Guillermo Creaney', '90 Northland Way', 'gcreaney31@sphinn.com', '2017-08-10 12:16:45', 'AvqtCV'),
	(111, 'Shell Demonge', '43662 Briar Crest Court', 'sdemonge32@yahoo.co.jp', '2018-09-19 09:24:23', 'ZoUUiNHMYiY'),
	(112, 'Willy Hadleigh', '31950 Chinook Crossing', 'whadleigh33@newsvine.com', '2021-04-26 05:25:47', 'EnMlahq0C37'),
	(113, 'Jemmie Gaze', '2 Lillian Pass', 'jgaze34@blinklist.com', '2018-07-17 16:15:30', 'AtX6j9'),
	(114, 'Iormina Gair', '23772 Ohio Road', 'igair35@psu.edu', '2021-02-03 06:49:54', 'GlaSMLuA6'),
	(115, 'Sybilla Woloschinski', '19398 Crowley Pass', 'swoloschinski36@redcross.org', '2014-10-04 14:34:31', 'HJC5Qwl9'),
	(116, 'Sigmund Egalton', '067 Farragut Junction', 'segalton37@webs.com', '2020-10-15 03:04:56', '4M3fkZ3sbn72'),
	(117, 'Brandy Shenton', '82785 Clyde Gallagher Circle', 'bshenton38@nytimes.com', '2016-05-31 23:05:46', 'Lsv1bZmMvi'),
	(118, 'Albrecht Aucourte', '687 Chive Hill', 'aaucourte39@samsung.com', '2020-11-05 04:36:23', 'YbVK5zE'),
	(119, 'Dalenna Laming', '71070 Warrior Drive', 'dlaming3a@netscape.com', '2018-05-31 22:33:30', 'TB29mvLuQJ9V'),
	(120, 'Tracie Gettens', '0942 Schurz Drive', 'tgettens3b@independent.co.uk', '2021-05-28 23:21:27', 'u0eg7Q1xZ'),
	(121, 'Carlene Jackett', '3884 Scott Way', 'cjackett3c@tiny.cc', '2014-08-12 01:46:06', 'ZJFSCNU9DIc'),
	(122, 'Rafaela Brackpool', '2076 Nancy Drive', 'rbrackpool3d@google.it', '2017-03-28 17:29:46', 'gNFKzxeJ'),
	(123, 'Bret Houlridge', '58586 Forest Court', 'bhoulridge3e@shareasale.com', '2014-12-14 22:01:48', 'cSYehS'),
	(124, 'Krispin Kingzett', '1370 Rigney Terrace', 'kkingzett3f@fc2.com', '2020-08-11 11:59:47', 'c1sraBY'),
	(125, 'Stanly Shovelin', '75 Orin Parkway', 'sshovelin3g@examiner.com', '2017-10-12 11:31:16', '4FcSrP'),
	(126, 'Ardelia Gherarducci', '060 Kipling Crossing', 'agherarducci3h@blogspot.com', '2017-02-11 23:37:54', 'TfDguo0Hv'),
	(127, 'Mallissa Seiter', '6490 Bartelt Street', 'mseiter3i@boston.com', '2020-03-27 19:26:49', 'fVByIzM3TA'),
	(128, 'Sissy Brownsey', '57 Kennedy Road', 'sbrownsey3j@4shared.com', '2015-04-17 22:20:10', 'OGX3GD5O'),
	(129, 'Windham Blythe', '60 American Ash Road', 'wblythe3k@chron.com', '2017-01-26 15:39:31', 'JwGF5s6k'),
	(130, 'Francois Ducket', '998 Golf Course Point', 'fducket3l@bloglines.com', '2016-07-05 05:09:19', '0yaaUjPYpZdN'),
	(131, 'Pattie Gofforth', '768 Roxbury Circle', 'pgofforth3m@icq.com', '2016-05-14 19:30:47', 'zQy9z7wvt'),
	(132, 'Conny Kearsley', '73 Milwaukee Place', 'ckearsley3n@latimes.com', '2016-06-14 10:24:22', '9OCpS2XQE1b'),
	(133, 'Aloysia Vondrach', '30022 Kings Court', 'avondrach3o@cdbaby.com', '2020-12-29 03:20:15', 'E7MoAcTBQB'),
	(134, 'Jeremie Pretty', '93 Pierstorff Terrace', 'jpretty3p@washington.edu', '2021-03-15 07:04:29', 'UT6kZ9qeizqL'),
	(135, 'Joachim Okker', '1 Canary Lane', 'jokker3q@themeforest.net', '2019-05-26 08:28:40', 'cZ1Bo6MslDXJ'),
	(136, 'Justen Nyles', '6875 Duke Terrace', 'jnyles3r@topsy.com', '2021-01-22 13:39:00', 'YuGCQgOc'),
	(137, 'Allene Hattiff', '12099 Mandrake Junction', 'ahattiff3s@mail.ru', '2016-12-07 16:09:22', 'IbkhxvEr9W'),
	(138, 'Zachery Hanselman', '453 Straubel Crossing', 'zhanselman3t@a8.net', '2018-04-02 21:53:13', 'i6TbyYy'),
	(139, 'Irena Atwater', '3448 Eliot Center', 'iatwater3u@boston.com', '2019-08-18 04:20:20', 'i8Q7oPH7T2'),
	(140, 'Sydney Kahan', '856 Little Fleur Plaza', 'skahan3v@patch.com', '2019-06-20 21:23:27', '2mfrbB'),
	(141, 'Marrissa Bifield', '5 Carberry Drive', 'mbifield3w@naver.com', '2021-06-09 09:57:52', '5s0a3ssC'),
	(142, 'Lizbeth Oager', '16 Buhler Drive', 'loager3x@canalblog.com', '2017-09-10 21:34:49', 'f1UxUPU'),
	(143, 'Carry Rykert', '3 Talisman Center', 'crykert3y@google.nl', '2021-04-19 11:19:17', 'yJYkLTPy'),
	(144, 'Gina Roos', '1513 Milwaukee Hill', 'groos3z@virginia.edu', '2014-12-14 06:32:18', '8tNvhcmsv'),
	(145, 'Genevieve Polly', '54805 Dennis Crossing', 'gpolly40@naver.com', '2019-02-03 08:32:10', '6Y9r2JOc'),
	(146, 'Tiffy Verlander', '8288 Main Way', 'tverlander41@npr.org', '2017-11-09 16:44:14', '4oqw3D1iIFkA'),
	(147, 'Reuven Lauderdale', '785 Boyd Parkway', 'rlauderdale42@wp.com', '2017-06-02 13:27:11', 'CrVAMdrW'),
	(148, 'Nelia Warlowe', '802 Dapin Park', 'nwarlowe43@mit.edu', '2017-01-26 11:35:53', 'ed3JVgHcwe2'),
	(149, 'Rad Fallens', '68 Bultman Road', 'rfallens44@4shared.com', '2016-05-29 17:56:14', 'vLBLX0L'),
	(150, 'Nina Wemyss', '82782 Porter Court', 'nwemyss45@walmart.com', '2015-10-28 09:27:55', 'CtaWdI6I6'),
	(151, 'Andy Falloon', '567 Fordem Terrace', 'afalloon46@multiply.com', '2018-04-02 00:33:39', 'vxLqSsyKXu'),
	(152, 'Eberto Girauld', '1 Mesta Crossing', 'egirauld47@yellowpages.com', '2015-02-17 06:50:21', '7ZWa08reiu'),
	(153, 'Franzen Woolmer', '37 Bluestem Place', 'fwoolmer48@ucla.edu', '2019-01-29 13:26:19', '3oy58zhZTB'),
	(154, 'Saunderson Pickerill', '411 Tennyson Terrace', 'spickerill49@merriam-webster.com', '2014-10-29 07:23:21', 'OfzQCq'),
	(155, 'Andrus Mapston', '0226 Manitowish Road', 'amapston4a@disqus.com', '2014-12-21 14:04:46', 'aKaEp5'),
	(156, 'Marwin Drezzer', '23169 Towne Center', 'mdrezzer4b@com.com', '2019-08-21 04:17:26', 'cKsOEeSgOj0t'),
	(157, 'Pet Basillon', '6820 Susan Avenue', 'pbasillon4c@opera.com', '2018-01-31 15:33:40', '3ON2nfusvzoM'),
	(158, 'Baron Hallibone', '9 Crowley Parkway', 'bhallibone4d@reuters.com', '2020-06-10 15:01:31', 'uzA8UINrFj'),
	(159, 'Rebbecca Favey', '93913 Lerdahl Plaza', 'rfavey4e@marketwatch.com', '2018-11-08 22:24:51', 'MDUBUH8Tb'),
	(160, 'Ruby Luard', '83 Springview Circle', 'rluard4f@yolasite.com', '2018-03-31 11:39:49', '5OZF22o9'),
	(161, 'Remy Trulocke', '309 Calypso Crossing', 'rtrulocke4g@sohu.com', '2015-10-24 20:58:59', 'tKbqHbC0scn'),
	(162, 'Ansell Grimble', '15 Northfield Plaza', 'agrimble4h@godaddy.com', '2016-02-23 07:34:37', 'f4GDgOknOS'),
	(163, 'Ileana Rudsdell', '00 Riverside Lane', 'irudsdell4i@msu.edu', '2019-07-07 00:51:34', '18bl4FQmDj'),
	(164, 'Shirley Needs', '606 Vidon Hill', 'sneeds4j@soup.io', '2016-09-08 06:54:19', '3TifuO68'),
	(165, 'Coralie Malkinson', '5 Prairie Rose Parkway', 'cmalkinson4k@angelfire.com', '2018-11-06 11:17:06', 'hbjLTaEXMjn'),
	(166, 'Yorgo Follacaro', '71 Lakewood Gardens Alley', 'yfollacaro4l@deliciousdays.com', '2019-10-19 14:08:23', 'gyJ1y2V8U'),
	(167, 'Lion Greenlies', '2 Amoth Lane', 'lgreenlies4m@cisco.com', '2018-03-14 22:07:46', 'ApY7x5S'),
	(168, 'Harland Astling', '1955 Oriole Plaza', 'hastling4n@blogs.com', '2017-03-12 20:45:16', 'FHR4JJ6mYC'),
	(169, 'Julia Eblein', '16 Valley Edge Center', 'jeblein4o@xinhuanet.com', '2021-03-02 18:59:03', 'cu3CxbW'),
	(170, 'Janis Ruttgers', '860 Lighthouse Bay Parkway', 'jruttgers4p@meetup.com', '2019-06-04 20:55:53', 'QKSUCOF3yBT'),
	(171, 'Shanan Shernock', '49 Red Cloud Drive', 'sshernock4q@google.com', '2015-02-11 18:55:12', 'ugI09vsEg'),
	(172, 'Melinde Aberchirder', '603 Nova Park', 'maberchirder4r@amazon.co.uk', '2020-05-20 15:31:09', 'RRw0AMZN'),
	(173, 'Robbyn Rains', '75380 Emmet Center', 'rrains4s@go.com', '2016-03-07 12:59:00', 'ymKODI'),
	(174, 'Deirdre Finlow', '573 Merchant Court', 'dfinlow4t@mac.com', '2020-06-11 20:37:32', 'IwpzvHZUrl0'),
	(175, 'Roy Bottjer', '89350 American Way', 'rbottjer4u@symantec.com', '2018-11-04 04:28:51', 'U4vCR8zWdT'),
	(176, 'Cobb Mott', '33342 Fisk Court', 'cmott4v@cisco.com', '2015-10-21 16:06:12', 'Afm37LMn'),
	(177, 'Truda Lowry', '66886 Little Fleur Way', 'tlowry4w@oakley.com', '2017-07-09 17:50:21', '2ktjC2T48Z'),
	(178, 'Tammie Eschalette', '02556 Brentwood Way', 'teschalette4x@pinterest.com', '2019-04-24 21:05:19', 'kado9Qvz'),
	(179, 'Essy Frayne', '300 Norway Maple Drive', 'efrayne4y@is.gd', '2020-11-21 21:24:23', '9HXh1R5dT'),
	(180, 'Cordy Proffitt', '441 Mandrake Crossing', 'cproffitt4z@google.com.hk', '2016-01-14 12:11:59', 'NZ4nWVcR'),
	(181, 'Sasha Kingerby', '671 Marquette Crossing', 'skingerby50@virginia.edu', '2014-08-17 14:59:02', 'ZYyLFthiKFdp'),
	(182, 'Regine Castelot', '7 Sunnyside Street', 'rcastelot51@jugem.jp', '2020-04-29 01:58:39', '3WaUxcwPRq3D'),
	(183, 'Fields Arbuckel', '355 Eastlawn Crossing', 'farbuckel52@bloglines.com', '2019-03-28 21:45:04', 'a9sEKE'),
	(184, 'Wash Anand', '88180 Rieder Hill', 'wanand53@privacy.gov.au', '2014-10-27 23:50:02', 'G12tZwlYK47s'),
	(185, 'Elnore Moller', '3576 Prairie Rose Street', 'emoller54@myspace.com', '2019-12-24 17:25:54', 'jYIZBNaBrWT'),
	(186, 'Aurelie Domm', '4221 Lakeland Road', 'adomm55@scientificamerican.com', '2019-06-02 01:01:15', 'R1hpH5J0sko8'),
	(187, 'Heda Yearron', '4 Hudson Trail', 'hyearron56@nymag.com', '2016-05-23 19:34:27', 'pHEDxVu'),
	(188, 'Bibbye Lawleff', '7812 Clemons Place', 'blawleff57@vkontakte.ru', '2021-01-10 11:10:01', '0IurZbSZ4UV1'),
	(189, 'Perrine Pavett', '8 Loeprich Way', 'ppavett58@cafepress.com', '2020-08-25 22:01:03', '7khzbgv'),
	(190, 'Theo Jozsef', '7486 Elka Pass', 'tjozsef59@tuttocitta.it', '2015-10-11 21:09:10', '16vvUbkPeiAS'),
	(191, 'Vaughn Nolleau', '8572 Bayside Terrace', 'vnolleau5a@indiegogo.com', '2019-09-21 01:17:30', 'TfbnEkbW1kJ'),
	(192, 'Annemarie Drohun', '112 7th Street', 'adrohun5b@oaic.gov.au', '2017-12-30 09:47:33', 'd4up2mqcw'),
	(193, 'Petrina Feechum', '50803 Ilene Street', 'pfeechum5c@phoca.cz', '2020-04-26 21:45:36', 'Aq48QKx'),
	(194, 'Vikki Addlestone', '7 Dwight Plaza', 'vaddlestone5d@4shared.com', '2019-12-26 07:44:28', 'O77ucqZ'),
	(195, 'Cosetta Abreheart', '91 Truax Drive', 'cabreheart5e@vimeo.com', '2014-08-25 17:55:25', 'Uf8jT4rZaBrG'),
	(196, 'Claudio Hubbis', '6862 Anzinger Trail', 'chubbis5f@usnews.com', '2017-06-15 16:20:23', 'CEULXuiHBl2'),
	(197, 'Gertie Gadsby', '543 Bonner Court', 'ggadsby5g@thetimes.co.uk', '2020-11-08 05:37:48', 'I6yGZ9Dxtn'),
	(198, 'Moritz Woodroff', '747 Melvin Alley', 'mwoodroff5h@kickstarter.com', '2017-09-02 10:04:33', 'GXMq1WWo3Kwl'),
	(199, 'Euell Mc Gaughey', '63948 Hintze Circle', 'emc5i@youtube.com', '2015-11-06 12:11:32', 'eBIIrX'),
	(200, 'Bianca Ryce', '99 Dwight Circle', 'bryce5j@geocities.com', '2017-03-29 00:58:27', '4uSgVLqplJC');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- Dumping structure for table rental_portal.extra
CREATE TABLE IF NOT EXISTS `extra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.extra: ~4 rows (approximately)
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

-- Dumping data for table rental_portal.feature: ~4 rows (approximately)
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.manufacturer: ~4 rows (approximately)
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
REPLACE INTO `manufacturer` (`id`, `name`) VALUES
	(1, 'BMW'),
	(2, 'Ford'),
	(3, 'Audi'),
	(4, 'VW');
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.rental: ~70 rows (approximately)
/*!40000 ALTER TABLE `rental` DISABLE KEYS */;
REPLACE INTO `rental` (`id`, `reservation_id`, `car_id`) VALUES
	(1, 88, 8),
	(2, 80, 20),
	(3, 77, 19),
	(4, 87, 19),
	(5, 87, 19),
	(6, 82, 3),
	(7, 3, 1),
	(8, 89, 23),
	(9, 34, 23),
	(10, 8, 13),
	(11, 35, 9),
	(12, 95, 22),
	(13, 70, 3),
	(14, 64, 15),
	(15, 81, 15),
	(16, 63, 16),
	(17, 77, 12),
	(18, 23, 22),
	(19, 65, 11),
	(20, 6, 4),
	(21, 98, 18),
	(22, 100, 12),
	(23, 48, 9),
	(24, 17, 24),
	(25, 55, 4),
	(26, 58, 9),
	(27, 6, 4),
	(28, 95, 15),
	(29, 50, 20),
	(30, 61, 22),
	(31, 99, 11),
	(32, 35, 6),
	(33, 47, 1),
	(34, 25, 9),
	(35, 91, 8),
	(36, 11, 1),
	(37, 29, 12),
	(38, 65, 24),
	(39, 46, 15),
	(40, 63, 21),
	(41, 91, 13),
	(42, 71, 5),
	(43, 100, 17),
	(44, 83, 9),
	(45, 73, 2),
	(46, 82, 20),
	(47, 12, 17),
	(48, 6, 1),
	(49, 25, 6),
	(50, 29, 10),
	(51, 74, 5),
	(52, 61, 19),
	(53, 25, 11),
	(54, 61, 9),
	(55, 43, 14),
	(56, 30, 10),
	(57, 37, 1),
	(58, 75, 19),
	(59, 31, 3),
	(60, 66, 16),
	(61, 12, 24),
	(62, 24, 22),
	(63, 24, 8),
	(64, 88, 15),
	(65, 22, 23),
	(66, 13, 15),
	(67, 47, 24),
	(68, 43, 5),
	(69, 63, 20),
	(70, 36, 14);
/*!40000 ALTER TABLE `rental` ENABLE KEYS */;

-- Dumping structure for table rental_portal.rental_station
CREATE TABLE IF NOT EXISTS `rental_station` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.rental_station: ~20 rows (approximately)
/*!40000 ALTER TABLE `rental_station` DISABLE KEYS */;
REPLACE INTO `rental_station` (`id`, `location`) VALUES
	(1, 'Angochi'),
	(2, 'Paprotnia'),
	(3, 'Mangge'),
	(4, 'Borova'),
	(5, 'Lons-le-Saunier'),
	(6, 'Pawa'),
	(7, 'Barranquilla'),
	(8, 'Igurusi'),
	(9, 'København'),
	(10, 'Pedra Furada'),
	(11, 'Chaodi'),
	(12, 'Middleton'),
	(13, 'Pag-asa'),
	(14, 'Longju'),
	(15, 'Mirandopólis'),
	(16, 'Grand-Bassam'),
	(17, 'Yitulihe'),
	(18, 'Olleros'),
	(19, 'Pimbalayan'),
	(20, 'Naftalan');
/*!40000 ALTER TABLE `rental_station` ENABLE KEYS */;

-- Dumping structure for table rental_portal.reservation
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `car_id` int DEFAULT NULL,
  `reserved_at` datetime DEFAULT NULL,
  `rent_from` datetime DEFAULT NULL,
  `rent_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `car_type_id` (`car_id`) USING BTREE,
  CONSTRAINT `FK_reservation_car` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`),
  CONSTRAINT `FK_reservation_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19802 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.reservation: ~100 rows (approximately)
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
REPLACE INTO `reservation` (`id`, `customer_id`, `car_id`, `reserved_at`, `rent_from`, `rent_to`) VALUES
	(1, 83, 15, '2017-08-23 15:41:01', '2019-09-26 00:44:17', '2020-08-31 05:12:46'),
	(2, 38, 7, '2018-03-14 21:10:55', '2019-07-11 09:28:36', '2021-12-21 00:25:00'),
	(3, 91, 11, '2018-05-25 23:52:59', '2019-09-12 00:19:57', '2020-10-24 08:38:15'),
	(4, 117, 14, '2017-12-29 20:35:29', '2020-04-06 12:00:52', '2022-02-27 06:22:02'),
	(5, 65, 22, '2018-03-09 12:26:14', '2018-11-22 11:49:03', '2022-05-28 21:43:57'),
	(6, 149, 9, '2018-04-17 15:22:45', '2019-02-19 21:08:01', '2020-09-16 19:25:26'),
	(7, 137, 3, '2018-05-23 14:07:44', '2019-07-03 11:33:00', '2021-08-08 17:58:51'),
	(8, 157, 14, '2017-09-11 18:29:51', '2020-01-17 15:44:04', '2020-08-01 03:48:18'),
	(9, 183, 14, '2017-06-19 04:24:04', '2019-02-21 23:26:55', '2021-06-13 22:10:06'),
	(10, 52, 24, '2018-02-20 22:29:38', '2018-11-17 03:34:52', '2020-12-16 06:14:33'),
	(11, 93, 17, '2017-06-06 20:16:20', '2019-11-14 20:24:42', '2020-09-02 23:01:43'),
	(12, 199, 13, '2018-01-23 05:06:31', '2020-01-17 00:14:57', '2021-06-17 04:02:19'),
	(13, 119, 16, '2017-10-20 14:39:03', '2019-02-13 07:34:22', '2020-09-26 03:48:31'),
	(14, 155, 21, '2018-05-02 09:17:20', '2019-07-13 03:28:01', '2022-04-19 17:35:16'),
	(15, 161, 20, '2018-06-07 06:29:53', '2018-07-05 20:08:01', '2020-10-21 00:32:36'),
	(16, 135, 17, '2017-06-24 01:40:57', '2020-05-13 04:54:50', '2021-06-19 16:49:41'),
	(17, 85, 12, '2017-06-25 14:09:12', '2019-02-12 00:11:40', '2020-08-18 09:10:57'),
	(18, 168, 6, '2017-06-15 02:14:12', '2020-01-13 23:41:47', '2022-04-22 00:57:48'),
	(19, 71, 22, '2018-02-09 20:32:26', '2019-04-07 21:52:50', '2021-02-11 11:31:50'),
	(20, 145, 11, '2018-01-21 00:58:41', '2019-11-05 23:32:23', '2021-08-18 15:49:08'),
	(21, 145, 2, '2018-06-07 18:48:03', '2019-08-24 10:25:08', '2021-05-21 13:50:07'),
	(22, 145, 8, '2017-10-28 22:18:07', '2020-05-05 11:01:34', '2021-05-13 10:08:24'),
	(23, 116, 20, '2017-10-04 20:45:05', '2019-06-12 07:34:21', '2021-01-11 16:13:45'),
	(24, 143, 2, '2018-06-02 17:45:25', '2019-07-29 10:01:40', '2021-07-02 16:13:34'),
	(25, 165, 17, '2018-04-01 20:31:52', '2018-10-22 20:34:09', '2021-12-07 17:59:19'),
	(26, 108, 23, '2017-12-26 03:36:58', '2018-09-13 06:16:47', '2021-02-28 03:15:50'),
	(27, 34, 15, '2017-08-05 17:28:03', '2020-01-19 02:59:03', '2020-08-24 01:38:56'),
	(28, 120, 14, '2017-06-07 12:20:37', '2019-03-11 21:13:50', '2020-11-21 23:50:51'),
	(29, 41, 8, '2017-09-04 14:47:03', '2018-11-09 19:54:02', '2021-11-23 20:14:42'),
	(30, 91, 23, '2017-05-14 02:12:27', '2020-04-05 18:06:59', '2022-04-14 19:36:12'),
	(31, 127, 18, '2017-10-24 08:24:52', '2019-04-03 02:41:38', '2020-08-28 11:15:43'),
	(32, 3, 5, '2017-10-05 04:11:00', '2020-05-11 12:56:23', '2021-08-13 00:27:36'),
	(33, 90, 18, '2017-07-19 08:34:17', '2018-12-28 06:03:21', '2020-08-23 00:00:33'),
	(34, 29, 17, '2017-08-20 09:53:36', '2020-03-02 03:18:48', '2021-12-31 07:31:56'),
	(35, 189, 7, '2017-10-24 00:50:18', '2019-03-12 22:31:26', '2021-05-20 08:52:55'),
	(36, 176, 11, '2018-01-13 13:37:24', '2019-08-04 01:14:12', '2020-08-18 19:39:18'),
	(37, 92, 11, '2017-06-07 15:30:27', '2018-08-30 18:28:51', '2021-02-18 03:22:33'),
	(38, 125, 10, '2017-12-24 20:25:36', '2020-03-29 19:54:56', '2021-07-22 11:36:48'),
	(39, 161, 14, '2017-11-07 13:29:53', '2020-05-16 17:22:05', '2020-12-17 05:28:33'),
	(40, 152, 3, '2017-11-19 00:31:14', '2019-02-28 04:09:37', '2021-11-29 17:26:22'),
	(41, 156, 18, '2018-02-20 11:45:27', '2020-02-25 17:44:21', '2022-04-04 17:49:00'),
	(42, 122, 11, '2017-10-16 02:48:37', '2019-08-01 19:34:54', '2021-05-23 09:54:38'),
	(43, 76, 16, '2017-10-07 15:54:52', '2019-06-26 17:04:23', '2022-01-09 20:30:07'),
	(44, 192, 5, '2017-08-13 19:47:58', '2019-06-07 04:10:37', '2020-09-14 13:30:17'),
	(45, 117, 16, '2017-09-14 19:07:49', '2018-07-12 09:16:35', '2021-09-21 05:10:50'),
	(46, 198, 12, '2018-02-15 04:05:12', '2019-09-23 06:06:51', '2021-03-13 17:10:34'),
	(47, 196, 5, '2018-01-24 15:41:58', '2019-11-26 11:23:37', '2021-07-03 14:24:51'),
	(48, 196, 5, '2017-09-22 06:27:19', '2019-04-28 07:42:36', '2022-03-22 14:46:36'),
	(49, 103, 6, '2017-08-24 06:36:29', '2018-12-06 17:44:01', '2020-12-22 17:19:36'),
	(50, 71, 14, '2018-05-06 21:53:10', '2018-11-22 12:44:04', '2021-03-16 07:18:19'),
	(51, 128, 17, '2017-08-09 22:15:06', '2019-08-27 18:44:13', '2021-01-02 18:55:46'),
	(52, 62, 10, '2018-01-13 13:32:12', '2018-08-07 01:43:24', '2022-02-20 07:51:36'),
	(53, 87, 21, '2018-03-03 21:24:17', '2019-05-29 16:48:22', '2021-02-16 21:34:51'),
	(54, 101, 11, '2018-01-23 19:51:47', '2018-08-23 07:48:51', '2021-11-23 21:09:45'),
	(55, 144, 11, '2017-06-27 09:24:36', '2020-02-01 10:45:12', '2022-04-27 03:03:27'),
	(56, 15, 4, '2018-03-24 23:05:53', '2018-12-28 20:11:24', '2021-06-27 00:30:12'),
	(57, 170, 14, '2018-03-07 03:16:17', '2019-10-09 23:07:59', '2021-03-27 07:45:46'),
	(58, 192, 5, '2018-01-19 10:15:44', '2019-01-01 03:04:07', '2021-07-04 16:59:22'),
	(59, 7, 7, '2017-08-20 20:57:43', '2018-09-03 02:20:46', '2022-04-23 23:58:10'),
	(60, 139, 22, '2018-03-06 13:59:19', '2018-12-31 20:28:48', '2020-12-10 20:11:03'),
	(61, 179, 24, '2017-10-07 17:23:18', '2019-01-17 08:58:42', '2021-07-11 04:33:13'),
	(62, 133, 6, '2017-12-22 04:35:08', '2019-10-17 09:17:14', '2021-11-05 19:26:28'),
	(63, 171, 6, '2017-07-26 18:19:11', '2018-11-21 07:03:58', '2022-05-04 12:55:06'),
	(64, 83, 24, '2018-05-05 19:06:55', '2020-01-17 20:27:31', '2022-02-07 02:50:30'),
	(65, 143, 8, '2017-05-25 18:06:15', '2020-03-14 06:10:16', '2022-06-01 03:53:34'),
	(66, 27, 10, '2017-07-20 19:42:31', '2019-08-23 16:22:55', '2021-08-06 19:18:03'),
	(67, 98, 6, '2017-10-28 14:18:49', '2018-12-23 19:28:10', '2022-01-27 13:09:53'),
	(68, 196, 8, '2017-06-10 21:02:35', '2018-10-11 11:52:33', '2021-09-24 13:00:13'),
	(69, 168, 1, '2018-02-08 17:31:47', '2020-03-11 07:23:19', '2021-12-30 21:52:09'),
	(70, 181, 2, '2017-10-19 23:50:09', '2018-09-10 01:43:33', '2020-12-16 13:54:45'),
	(71, 80, 9, '2017-12-04 16:39:27', '2018-10-24 12:07:05', '2022-05-15 23:38:34'),
	(72, 85, 8, '2018-04-13 05:18:30', '2019-04-23 00:44:25', '2021-02-02 16:05:55'),
	(73, 30, 24, '2018-04-10 12:56:21', '2019-12-24 06:26:43', '2022-06-08 08:31:06'),
	(74, 109, 16, '2018-02-18 08:22:19', '2020-04-21 11:13:43', '2021-07-01 18:30:35'),
	(75, 199, 13, '2017-09-28 06:33:39', '2018-08-20 23:36:14', '2022-05-30 00:12:58'),
	(76, 166, 9, '2017-06-06 21:05:29', '2018-09-07 13:06:35', '2021-12-08 05:56:44'),
	(77, 67, 14, '2017-07-24 18:34:45', '2018-08-17 01:13:37', '2021-06-16 12:40:42'),
	(78, 71, 9, '2018-04-15 01:02:13', '2018-07-30 16:06:01', '2021-08-30 21:17:22'),
	(79, 34, 15, '2017-05-23 16:29:43', '2020-05-01 18:19:17', '2021-12-31 00:02:24'),
	(80, 27, 13, '2017-11-04 23:15:56', '2019-11-24 04:15:30', '2021-10-14 01:07:05'),
	(81, 140, 11, '2017-09-27 13:27:20', '2020-04-13 05:28:49', '2022-02-26 05:50:44'),
	(82, 75, 12, '2018-03-25 02:56:44', '2020-04-10 04:21:45', '2021-07-23 11:44:41'),
	(83, 4, 6, '2018-05-18 23:33:57', '2019-05-18 08:12:46', '2021-11-03 09:03:19'),
	(84, 12, 7, '2017-12-24 18:25:35', '2018-07-04 08:42:54', '2021-07-08 02:21:31'),
	(85, 14, 19, '2017-09-04 13:44:12', '2018-07-20 15:33:10', '2022-02-05 05:03:07'),
	(86, 131, 1, '2018-01-10 08:45:19', '2019-11-29 18:46:23', '2021-04-24 11:13:48'),
	(87, 147, 16, '2017-07-31 10:17:27', '2018-09-06 15:19:33', '2021-01-24 01:03:31'),
	(88, 188, 13, '2017-12-21 18:10:49', '2019-04-03 20:49:22', '2021-08-27 03:20:12'),
	(89, 184, 7, '2018-04-20 09:48:07', '2020-04-20 08:54:26', '2020-08-22 22:24:56'),
	(90, 79, 24, '2018-03-26 16:36:37', '2018-09-19 18:58:00', '2021-12-20 15:24:44'),
	(91, 51, 3, '2018-05-23 01:35:42', '2019-11-06 00:20:47', '2022-04-27 05:02:00'),
	(92, 116, 21, '2018-06-08 16:35:13', '2019-03-16 16:06:04', '2020-07-26 23:46:18'),
	(93, 26, 7, '2017-10-19 21:38:01', '2019-06-21 01:38:05', '2021-02-23 17:22:34'),
	(94, 65, 7, '2018-02-17 18:14:09', '2019-09-22 16:45:48', '2021-11-05 15:21:54'),
	(95, 175, 3, '2017-10-12 02:48:20', '2019-09-17 14:42:03', '2021-05-26 20:54:11'),
	(96, 94, 10, '2017-06-01 13:14:34', '2019-05-14 21:48:41', '2020-12-07 12:49:43'),
	(97, 143, 8, '2018-05-15 22:05:54', '2019-02-10 23:04:00', '2021-12-13 10:01:10'),
	(98, 21, 6, '2018-01-21 02:41:01', '2018-10-22 04:47:23', '2021-08-31 10:04:49'),
	(99, 170, 4, '2017-08-21 18:37:31', '2019-09-01 15:39:56', '2021-12-22 12:58:31'),
	(100, 185, 22, '2017-10-26 16:56:28', '2019-02-11 18:59:17', '2020-12-27 11:45:59');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;

-- Dumping structure for table rental_portal.take_back_protocol
CREATE TABLE IF NOT EXISTS `take_back_protocol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rental_id` int DEFAULT NULL,
  `cur_kilometers` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_id` (`rental_id`),
  CONSTRAINT `take_back_protocol_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- Dumping data for table rental_portal.take_back_protocol: ~30 rows (approximately)
/*!40000 ALTER TABLE `take_back_protocol` DISABLE KEYS */;
REPLACE INTO `take_back_protocol` (`id`, `rental_id`, `cur_kilometers`) VALUES
	(1, 68, 193444),
	(2, 51, 15043),
	(3, 48, 148730),
	(4, 21, 149934),
	(5, 51, 21874),
	(6, 63, 34371),
	(7, 47, 36442),
	(8, 56, 22496),
	(9, 47, 196070),
	(10, 43, 158870),
	(11, 22, 20922),
	(12, 38, 98986),
	(13, 45, 137121),
	(14, 66, 43877),
	(15, 37, 59544),
	(16, 68, 68510),
	(17, 60, 149084),
	(18, 59, 148145),
	(19, 38, 43765),
	(20, 5, 24015),
	(21, 24, 164791),
	(22, 15, 69278),
	(23, 16, 121212),
	(24, 64, 97529),
	(25, 35, 159165),
	(26, 17, 58960),
	(27, 39, 181307),
	(28, 6, 198180),
	(29, 7, 48182),
	(30, 19, 82473);
/*!40000 ALTER TABLE `take_back_protocol` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
