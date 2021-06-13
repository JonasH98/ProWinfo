-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               8.0.25 - MySQL Community Server - GPL
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Exportiere Struktur von Tabelle rental_portal.car
CREATE TABLE IF NOT EXISTS `car` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rental_station_id` int DEFAULT NULL,
  `car_class_id` int DEFAULT NULL,
  `manufacturer_id` int DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_station_id` (`rental_station_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `car_type_id` (`car_class_id`) USING BTREE,
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`rental_station_id`) REFERENCES `rental_station` (`id`),
  CONSTRAINT `car_ibfk_3` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`),
  CONSTRAINT `FK_car_car_class` FOREIGN KEY (`car_class_id`) REFERENCES `car_class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.car: ~24 rows (ungefähr)
DELETE FROM `car`;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` (`id`, `rental_station_id`, `car_class_id`, `manufacturer_id`, `image_url`) VALUES
	(1, 14, 1, 3, NULL),
	(2, 15, 1, 1, NULL),
	(3, 8, 1, 2, NULL),
	(4, 18, 1, 4, NULL),
	(5, 14, 6, 4, NULL),
	(6, 13, 6, 2, NULL),
	(7, 3, 6, 1, NULL),
	(8, 2, 6, 3, NULL),
	(9, 19, 2, 4, NULL),
	(10, 9, 2, 2, NULL),
	(11, 6, 2, 1, NULL),
	(12, 12, 2, 3, NULL),
	(13, 5, 3, 4, NULL),
	(14, 3, 3, 2, NULL),
	(15, 6, 3, 1, NULL),
	(16, 14, 3, 3, NULL),
	(17, 16, 4, 4, NULL),
	(18, 1, 4, 2, NULL),
	(19, 8, 4, 1, NULL),
	(20, 17, 4, 3, NULL),
	(21, 18, 5, 4, NULL),
	(22, 1, 5, 2, NULL),
	(23, 15, 5, 1, NULL),
	(24, 20, 5, 3, NULL);
/*!40000 ALTER TABLE `car` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.car_class
CREATE TABLE IF NOT EXISTS `car_class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.car_class: ~6 rows (ungefähr)
DELETE FROM `car_class`;
/*!40000 ALTER TABLE `car_class` DISABLE KEYS */;
INSERT INTO `car_class` (`id`, `name`) VALUES
	(1, 'Kleinwagen'),
	(2, 'Kompaktklasse'),
	(3, 'Mittelklasse'),
	(4, 'Oberklasse'),
	(5, 'SUV'),
	(6, 'Kombi');
/*!40000 ALTER TABLE `car_class` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.car_type
CREATE TABLE IF NOT EXISTS `car_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seats` varchar(50) DEFAULT NULL,
  `doors` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.car_type: ~8 rows (ungefähr)
DELETE FROM `car_type`;
/*!40000 ALTER TABLE `car_type` DISABLE KEYS */;
INSERT INTO `car_type` (`id`, `seats`, `doors`) VALUES
	(1, '2-3', '2-3'),
	(2, '4-5', '2-3'),
	(3, '6-7', '2-3'),
	(4, '8-9', '2-3'),
	(5, '2-3', '4-5'),
	(6, '4-5', '4-5'),
	(7, '6-7', '4-5'),
	(8, '8-9', '4-5');
/*!40000 ALTER TABLE `car_type` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.car_type_class
CREATE TABLE IF NOT EXISTS `car_type_class` (
  `car_type_id` int DEFAULT NULL,
  `car_class_id` int DEFAULT NULL,
  KEY `car_type_id` (`car_type_id`),
  KEY `car_class_id` (`car_class_id`),
  CONSTRAINT `car_type_class_ibfk_1` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_type_class_ibfk_2` FOREIGN KEY (`car_class_id`) REFERENCES `car_class` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.car_type_class: ~6 rows (ungefähr)
DELETE FROM `car_type_class`;
/*!40000 ALTER TABLE `car_type_class` DISABLE KEYS */;
INSERT INTO `car_type_class` (`car_type_id`, `car_class_id`) VALUES
	(4, 2),
	(7, 3),
	(1, 4),
	(8, 5),
	(2, 1),
	(6, 6);
/*!40000 ALTER TABLE `car_type_class` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.car_type_extra
CREATE TABLE IF NOT EXISTS `car_type_extra` (
  `car_type_id` int DEFAULT NULL,
  `extra_id` int DEFAULT NULL,
  KEY `car_type_id` (`car_type_id`),
  KEY `extra_id` (`extra_id`),
  CONSTRAINT `car_type_extra_ibfk_1` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_type_extra_ibfk_2` FOREIGN KEY (`extra_id`) REFERENCES `extra` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.car_type_extra: ~4 rows (ungefähr)
DELETE FROM `car_type_extra`;
/*!40000 ALTER TABLE `car_type_extra` DISABLE KEYS */;
INSERT INTO `car_type_extra` (`car_type_id`, `extra_id`) VALUES
	(3, 4),
	(6, 2),
	(4, 4),
	(8, 1);
/*!40000 ALTER TABLE `car_type_extra` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.car_type_feature
CREATE TABLE IF NOT EXISTS `car_type_feature` (
  `car_type_id` int DEFAULT NULL,
  `feature_id` int DEFAULT NULL,
  KEY `car_type_id` (`car_type_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `car_type_feature_ibfk_1` FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`),
  CONSTRAINT `car_type_feature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.car_type_feature: ~4 rows (ungefähr)
DELETE FROM `car_type_feature`;
/*!40000 ALTER TABLE `car_type_feature` DISABLE KEYS */;
INSERT INTO `car_type_feature` (`car_type_id`, `feature_id`) VALUES
	(8, 2),
	(1, 1),
	(2, 4),
	(3, 3);
/*!40000 ALTER TABLE `car_type_feature` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.customer: ~200 rows (ungefähr)
DELETE FROM `customer`;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` (`id`, `full_name`, `address`, `email`, `created_at`) VALUES
	(1, 'Morgen Spradbrow', '2 Stephen Hill', 'mspradbrow0@hugedomains.com', '2016-02-23 00:29:00'),
	(2, 'Terrell Melbury', '5 Nancy Hill', 'tmelbury1@flickr.com', '2015-10-13 12:22:54'),
	(3, 'Janey Gilffilland', '817 Hansons Parkway', 'jgilffilland2@xing.com', '2018-02-15 06:30:14'),
	(4, 'Chelsae Ivimey', '28700 Straubel Avenue', 'civimey3@friendfeed.com', '2016-09-03 02:35:45'),
	(5, 'Jordana Martignon', '6644 Chive Center', 'jmartignon4@php.net', '2019-07-29 17:06:07'),
	(6, 'Yettie Yarmouth', '7 Lillian Place', 'yyarmouth5@simplemachines.org', '2019-06-10 01:41:04'),
	(7, 'Chiquita Kirton', '242 Paget Junction', 'ckirton6@netvibes.com', '2021-05-04 18:15:26'),
	(8, 'Eilis Coch', '6 Barnett Trail', 'ecoch7@de.vu', '2018-05-11 05:43:09'),
	(9, 'Neddy Ceschi', '0 Homewood Court', 'nceschi8@webs.com', '2016-01-08 08:34:33'),
	(10, 'Carie Twelve', '0071 Mandrake Junction', 'ctwelve9@msn.com', '2020-07-17 15:11:48'),
	(11, 'Ryan Slipper', '1981 Mariners Cove Street', 'rslippera@squidoo.com', '2015-11-24 06:08:27'),
	(12, 'Neville Yaus', '3 American Ash Place', 'nyausb@tamu.edu', '2019-01-16 06:17:16'),
	(13, 'Morganica Buckham', '0 Center Court', 'mbuckhamc@behance.net', '2020-01-24 02:26:03'),
	(14, 'Salvador Conklin', '8493 Clyde Gallagher Parkway', 'sconklind@un.org', '2020-02-10 20:10:40'),
	(15, 'Towny Vogl', '2 Vermont Trail', 'tvogle@umich.edu', '2018-07-15 02:43:46'),
	(16, 'Merlina Pietasch', '1 Dorton Trail', 'mpietaschf@usgs.gov', '2016-01-21 01:04:36'),
	(17, 'Desiri Smallacombe', '1 Debs Avenue', 'dsmallacombeg@hao123.com', '2016-05-26 05:04:06'),
	(18, 'Brant Bloxam', '71550 Superior Center', 'bbloxamh@senate.gov', '2020-09-11 08:12:12'),
	(19, 'Juan Ambrogio', '152 Monterey Alley', 'jambrogioi@php.net', '2018-09-09 19:17:27'),
	(20, 'Bernadette Gilchrist', '8 Sachtjen Terrace', 'bgilchristj@wordpress.com', '2020-08-28 08:00:00'),
	(21, 'Ninnette Luesley', '995 Cody Terrace', 'nluesleyk@mapquest.com', '2016-01-02 06:06:16'),
	(22, 'Rourke Eicheler', '26630 Badeau Point', 'reichelerl@blogs.com', '2017-12-04 00:25:05'),
	(23, 'Roscoe Chatelet', '56872 Shoshone Hill', 'rchateletm@slideshare.net', '2015-11-06 12:09:23'),
	(24, 'Hanny Hambribe', '503 Stone Corner Alley', 'hhambriben@wunderground.com', '2018-08-16 10:04:11'),
	(25, 'Roxine Juleff', '328 Mcbride Alley', 'rjuleffo@mit.edu', '2017-08-09 00:14:02'),
	(26, 'Jerry Crumby', '9124 Elmside Alley', 'jcrumbyp@microsoft.com', '2020-04-18 03:25:55'),
	(27, 'Gianni Strettell', '8142 Corben Avenue', 'gstrettellq@comcast.net', '2018-06-19 10:03:08'),
	(28, 'Patin Cossons', '29596 Judy Pass', 'pcossonsr@ucsd.edu', '2017-06-08 09:37:52'),
	(29, 'Cletis Bermingham', '3600 Tony Lane', 'cberminghams@clickbank.net', '2019-01-17 20:32:19'),
	(30, 'Ariella Lyte', '5 Longview Trail', 'alytet@theglobeandmail.com', '2015-08-21 11:36:46'),
	(31, 'Elli Gethings', '0 Trailsway Parkway', 'egethingsu@surveymonkey.com', '2018-12-21 18:41:38'),
	(32, 'Ronna Bauldry', '036 Ridge Oak Lane', 'rbauldryv@squarespace.com', '2020-05-07 03:46:54'),
	(33, 'Dur Oldfield', '0916 Farragut Court', 'doldfieldw@wikispaces.com', '2016-01-03 22:38:28'),
	(34, 'Gerty Antonellini', '685 Wayridge Way', 'gantonellinix@techcrunch.com', '2016-12-18 21:01:40'),
	(35, 'Maegan Glasscoo', '23 Merry Junction', 'mglasscooy@bigcartel.com', '2018-12-07 13:12:31'),
	(36, 'Alaric Bolter', '8 Carey Court', 'abolterz@slideshare.net', '2018-08-02 15:13:51'),
	(37, 'Susann Mackrill', '98 Melody Center', 'smackrill10@blog.com', '2021-04-28 16:47:08'),
	(38, 'Quinn Uzelli', '77 Waubesa Park', 'quzelli11@zdnet.com', '2019-09-09 03:40:26'),
	(39, 'Garnette Peatt', '8 Orin Trail', 'gpeatt12@ft.com', '2020-10-03 20:05:33'),
	(40, 'Averell Milier', '1 Melrose Court', 'amilier13@g.co', '2018-03-25 06:29:52'),
	(41, 'Warden Crumley', '216 Aberg Avenue', 'wcrumley14@rakuten.co.jp', '2018-01-18 22:35:14'),
	(42, 'Othello Cassell', '9 Mayfield Hill', 'ocassell15@icq.com', '2016-02-05 13:21:49'),
	(43, 'Meaghan Rabb', '209 Sunnyside Trail', 'mrabb16@photobucket.com', '2020-05-29 07:45:09'),
	(44, 'Mordecai Sazio', '30 Farwell Crossing', 'msazio17@tripod.com', '2020-06-06 19:17:48'),
	(45, 'Bartolomeo Nussgen', '320 Chive Trail', 'bnussgen18@webmd.com', '2020-03-26 00:16:50'),
	(46, 'Desiri Osmon', '7197 Kensington Parkway', 'dosmon19@ox.ac.uk', '2020-10-13 08:14:13'),
	(47, 'El Darlison', '03042 Sauthoff Junction', 'edarlison1a@jiathis.com', '2021-02-21 07:37:37'),
	(48, 'Sammie Royds', '445 Cascade Hill', 'sroyds1b@parallels.com', '2020-06-27 17:44:47'),
	(49, 'Penelopa Tichelaar', '20150 Mallard Way', 'ptichelaar1c@irs.gov', '2018-06-21 15:30:10'),
	(50, 'Bastian Rumbelow', '8 Center Street', 'brumbelow1d@nydailynews.com', '2016-09-28 19:48:09'),
	(51, 'Merrili Keirl', '4 Doe Crossing Lane', 'mkeirl1e@multiply.com', '2018-01-06 09:16:14'),
	(52, 'Beryle Izhak', '21 Loftsgordon Center', 'bizhak1f@ebay.co.uk', '2020-08-28 00:30:51'),
	(53, 'Angel Bewshea', '23 Division Way', 'abewshea1g@homestead.com', '2017-10-07 08:31:06'),
	(54, 'Averell Gilliard', '1 Westend Street', 'agilliard1h@amazon.de', '2020-03-12 01:27:14'),
	(55, 'Jaclin Dugood', '2 Troy Crossing', 'jdugood1i@wufoo.com', '2019-12-14 12:11:25'),
	(56, 'Sheelah Thornhill', '2679 Buena Vista Plaza', 'sthornhill1j@ycombinator.com', '2020-11-30 00:26:55'),
	(57, 'Elvin Letterese', '17 Red Cloud Lane', 'eletterese1k@adobe.com', '2019-11-10 15:15:30'),
	(58, 'Kristal Amer', '5671 Loeprich Road', 'kamer1l@ocn.ne.jp', '2018-04-17 14:45:48'),
	(59, 'Ruben Vinck', '46 Quincy Park', 'rvinck1m@rediff.com', '2020-09-29 21:36:05'),
	(60, 'Winnie Prator', '3904 Basil Parkway', 'wprator1n@nifty.com', '2019-04-12 19:40:52'),
	(61, 'Romona Layman', '16 Merry Place', 'rlayman1o@vkontakte.ru', '2021-05-18 10:06:35'),
	(62, 'Rozella Mearns', '1377 Esch Way', 'rmearns1p@home.pl', '2019-03-05 19:03:52'),
	(63, 'Lynnelle Kleinplac', '9892 Tennyson Lane', 'lkleinplac1q@timesonline.co.uk', '2017-04-29 23:48:15'),
	(64, 'Ricca Wiggington', '26224 7th Road', 'rwiggington1r@nba.com', '2016-09-10 00:18:11'),
	(65, 'Dale Hurleston', '06 Ilene Junction', 'dhurleston1s@lulu.com', '2018-02-07 12:52:38'),
	(66, 'Giraud Kyndred', '213 Del Sol Parkway', 'gkyndred1t@elegantthemes.com', '2019-07-16 20:17:26'),
	(67, 'Maximilian O\'Hingerty', '4248 Barby Hill', 'mohingerty1u@php.net', '2021-03-25 01:23:34'),
	(68, 'Emilie Hussey', '39289 Artisan Alley', 'ehussey1v@ebay.co.uk', '2019-08-06 12:27:53'),
	(69, 'Merrile Macak', '2 Northland Parkway', 'mmacak1w@liveinternet.ru', '2019-01-16 20:21:29'),
	(70, 'Teddie Norkutt', '33 Gale Place', 'tnorkutt1x@oakley.com', '2017-09-29 03:37:07'),
	(71, 'Kerr Calbreath', '65687 Dayton Plaza', 'kcalbreath1y@photobucket.com', '2016-10-12 23:53:41'),
	(72, 'Lauretta Dickins', '6 Grasskamp Plaza', 'ldickins1z@smh.com.au', '2016-02-10 08:33:09'),
	(73, 'Yard Balas', '62 Ridge Oak Parkway', 'ybalas20@pen.io', '2017-06-18 01:29:21'),
	(74, 'Marlow Longfoot', '9831 Coleman Pass', 'mlongfoot21@sina.com.cn', '2016-06-23 16:36:54'),
	(75, 'Diann Argontt', '84652 Michigan Parkway', 'dargontt22@seattletimes.com', '2021-02-23 07:12:08'),
	(76, 'Fleur Pruvost', '5 Mayer Terrace', 'fpruvost23@goo.gl', '2015-12-25 11:29:38'),
	(77, 'Micaela Balazin', '346 6th Park', 'mbalazin24@archive.org', '2019-05-24 08:17:44'),
	(78, 'Bennie Parkins', '0567 Blackbird Circle', 'bparkins25@cocolog-nifty.com', '2016-09-09 19:19:55'),
	(79, 'Emelen Windley', '2273 Knutson Circle', 'ewindley26@whitehouse.gov', '2019-09-25 13:58:25'),
	(80, 'Helen Smail', '025 Forster Lane', 'hsmail27@infoseek.co.jp', '2019-05-24 23:22:41'),
	(81, 'Annamaria Asgodby', '8 Shasta Crossing', 'aasgodby28@yellowbook.com', '2016-08-31 18:02:22'),
	(82, 'Meier Manifold', '10296 Fordem Pass', 'mmanifold29@mapquest.com', '2019-02-24 10:29:34'),
	(83, 'Bernarr Driver', '15 Melby Center', 'bdriver2a@nbcnews.com', '2020-10-28 03:18:31'),
	(84, 'Analise Chalfant', '9 Lerdahl Court', 'achalfant2b@biblegateway.com', '2019-06-24 10:56:42'),
	(85, 'Jen Whettleton', '01 Loomis Center', 'jwhettleton2c@hexun.com', '2020-09-06 17:40:52'),
	(86, 'Karmen Frew', '9 Scoville Hill', 'kfrew2d@alexa.com', '2020-03-01 12:14:09'),
	(87, 'Gwendolyn Packham', '5 Meadow Vale Alley', 'gpackham2e@marketwatch.com', '2015-09-14 08:06:29'),
	(88, 'Mariska Huncote', '5 John Wall Plaza', 'mhuncote2f@ifeng.com', '2020-06-04 03:00:14'),
	(89, 'Drusie Meach', '68669 6th Court', 'dmeach2g@wikimedia.org', '2019-01-31 07:51:57'),
	(90, 'Yanaton Melluish', '15 Springview Plaza', 'ymelluish2h@elpais.com', '2020-09-08 21:51:42'),
	(91, 'Adamo Whitehair', '13872 Veith Center', 'awhitehair2i@seesaa.net', '2018-01-03 09:36:50'),
	(92, 'Lawry Mawdsley', '40595 Forest Dale Point', 'lmawdsley2j@nydailynews.com', '2016-03-29 01:39:02'),
	(93, 'Colver Sabates', '33 Debra Plaza', 'csabates2k@webmd.com', '2017-04-17 01:45:35'),
	(94, 'Madelon Wilding', '51904 Waubesa Circle', 'mwilding2l@gnu.org', '2017-07-15 09:22:30'),
	(95, 'Lorrie Kilian', '339 Carberry Parkway', 'lkilian2m@loc.gov', '2019-11-22 16:37:01'),
	(96, 'Fredi Kabisch', '73 Express Road', 'fkabisch2n@joomla.org', '2018-10-13 14:33:54'),
	(97, 'Darcy Obey', '464 Loftsgordon Trail', 'dobey2o@dedecms.com', '2016-11-16 12:24:58'),
	(98, 'Elia O\' Donohue', '37 Claremont Pass', 'eo2p@arizona.edu', '2020-09-07 18:46:17'),
	(99, 'Allison McTeggart', '64341 Hovde Pass', 'amcteggart2q@xing.com', '2018-04-22 10:38:38'),
	(100, 'Christiana Hawtry', '8113 Prairieview Road', 'chawtry2r@usnews.com', '2016-10-13 21:43:19'),
	(101, 'Arlette Conen', '32 Bonner Trail', 'aconen2s@simplemachines.org', '2017-05-09 22:19:23'),
	(102, 'Zaneta Mathou', '978 Sheridan Hill', 'zmathou2t@nba.com', '2020-07-27 12:23:36'),
	(103, 'Glori Stainburn', '868 Boyd Crossing', 'gstainburn2u@furl.net', '2016-04-19 15:31:25'),
	(104, 'Joyan Schulz', '296 Bluestem Street', 'jschulz2v@ask.com', '2018-10-20 09:40:40'),
	(105, 'Dan Scones', '26 Burning Wood Parkway', 'dscones2w@gravatar.com', '2017-07-23 11:26:17'),
	(106, 'Pavla Garlinge', '20 Waxwing Pass', 'pgarlinge2x@dailymotion.com', '2016-01-03 09:18:28'),
	(107, 'Kelbee Beynon', '77810 Grayhawk Parkway', 'kbeynon2y@cbslocal.com', '2019-07-18 18:25:19'),
	(108, 'Nichole O\'Logan', '45 Graedel Way', 'nologan2z@wordpress.org', '2018-03-17 04:20:17'),
	(109, 'Dannel Licence', '98 Iowa Parkway', 'dlicence30@netlog.com', '2018-07-18 05:12:51'),
	(110, 'Josefina Atte-Stone', '1848 Northview Park', 'jattestone31@flickr.com', '2018-05-23 03:21:28'),
	(111, 'Clementia Cholwell', '9 Vera Way', 'ccholwell32@usda.gov', '2017-08-03 00:59:59'),
	(112, 'Alwyn Sanz', '5 Merchant Pass', 'asanz33@nymag.com', '2021-01-29 04:42:27'),
	(113, 'Gare Nuschke', '4681 Schiller Trail', 'gnuschke34@creativecommons.org', '2021-04-09 22:38:11'),
	(114, 'Janine Blemen', '8436 Pawling Circle', 'jblemen35@naver.com', '2019-05-02 07:48:19'),
	(115, 'Car Jankowski', '49522 Canary Lane', 'cjankowski36@ihg.com', '2018-11-25 23:29:50'),
	(116, 'Vere Swainsbury', '691 6th Trail', 'vswainsbury37@cnn.com', '2018-06-14 10:38:26'),
	(117, 'Tanhya Murrhardt', '5372 Jana Pass', 'tmurrhardt38@stanford.edu', '2017-02-07 14:36:25'),
	(118, 'Mignon Salter', '31767 7th Terrace', 'msalter39@businessinsider.com', '2017-11-23 04:13:42'),
	(119, 'Paulo Serrels', '88567 Westport Pass', 'pserrels3a@walmart.com', '2019-12-15 11:22:03'),
	(120, 'Cassy Andrieu', '60876 Almo Road', 'candrieu3b@ning.com', '2017-09-11 16:55:11'),
	(121, 'Marrissa McBride', '853 Forster Hill', 'mmcbride3c@nymag.com', '2018-04-01 22:11:02'),
	(122, 'Anthea Thaw', '6986 Butterfield Hill', 'athaw3d@spotify.com', '2019-02-09 12:05:08'),
	(123, 'Blythe Miko', '225 Oakridge Alley', 'bmiko3e@furl.net', '2019-03-19 17:05:49'),
	(124, 'Rennie Gut', '22374 Dapin Way', 'rgut3f@nba.com', '2019-05-28 19:54:45'),
	(125, 'Kate Penton', '09 Hoffman Road', 'kpenton3g@nationalgeographic.com', '2019-01-20 15:36:08'),
	(126, 'Ilyssa Erik', '42 Forest Center', 'ierik3h@smh.com.au', '2018-09-03 00:53:31'),
	(127, 'Pandora Povah', '67 Lakewood Gardens Center', 'ppovah3i@netscape.com', '2019-08-12 18:39:15'),
	(128, 'Blythe Danielkiewicz', '595 Troy Court', 'bdanielkiewicz3j@gizmodo.com', '2016-04-14 08:34:55'),
	(129, 'Woodman Van der Hoeven', '32 Walton Park', 'wvan3k@time.com', '2017-01-30 11:25:09'),
	(130, 'Elise Filyaev', '76 4th Hill', 'efilyaev3l@wikispaces.com', '2019-10-12 01:19:08'),
	(131, 'Celka Grinter', '66 Sunfield Hill', 'cgrinter3m@blog.com', '2020-01-14 12:36:06'),
	(132, 'Dermot Kobelt', '5 Dorton Terrace', 'dkobelt3n@geocities.jp', '2019-02-26 22:51:04'),
	(133, 'Osbert Wheatman', '19672 Wayridge Place', 'owheatman3o@geocities.jp', '2016-07-10 08:34:43'),
	(134, 'Kristal Medhurst', '85645 Moulton Pass', 'kmedhurst3p@ft.com', '2017-10-03 03:10:51'),
	(135, 'Fianna Adamolli', '6 Utah Street', 'fadamolli3q@wikia.com', '2020-10-23 05:57:43'),
	(136, 'Allison Boltwood', '2414 Schlimgen Lane', 'aboltwood3r@sina.com.cn', '2015-09-10 08:03:55'),
	(137, 'Gabi Torbett', '784 Fulton Pass', 'gtorbett3s@is.gd', '2018-03-11 18:59:51'),
	(138, 'Alexander Fydoe', '58447 Loeprich Center', 'afydoe3t@icq.com', '2020-12-05 16:48:16'),
	(139, 'Alexine Hainsworth', '6 Huxley Pass', 'ahainsworth3u@samsung.com', '2020-04-05 05:04:10'),
	(140, 'Daveen Follin', '4 Thackeray Pass', 'dfollin3v@hubpages.com', '2015-12-25 08:04:42'),
	(141, 'Nannie Lamshead', '40838 Eastlawn Hill', 'nlamshead3w@uiuc.edu', '2020-06-11 21:12:55'),
	(142, 'Misha Hayers', '0 Surrey Street', 'mhayers3x@reverbnation.com', '2016-02-08 19:08:32'),
	(143, 'Bernie Branwhite', '79 Fairview Court', 'bbranwhite3y@nps.gov', '2017-05-26 21:26:26'),
	(144, 'Jessy Winspire', '118 Upham Street', 'jwinspire3z@facebook.com', '2019-02-09 01:45:26'),
	(145, 'Smith Cattermoul', '8821 Dayton Road', 'scattermoul40@desdev.cn', '2020-06-24 04:10:15'),
	(146, 'Marillin Gabits', '1 Sheridan Circle', 'mgabits41@feedburner.com', '2018-04-30 15:28:15'),
	(147, 'Cathe Dripp', '13 Sage Way', 'cdripp42@etsy.com', '2018-01-30 05:22:00'),
	(148, 'Myer Duckerin', '512 Clemons Terrace', 'mduckerin43@artisteer.com', '2016-10-06 10:44:15'),
	(149, 'Ivett Addekin', '83160 Fallview Center', 'iaddekin44@ovh.net', '2019-01-16 22:57:25'),
	(150, 'Leyla Rippin', '51 Lien Pass', 'lrippin45@vkontakte.ru', '2019-06-15 19:59:19'),
	(151, 'Alla Sparkwill', '70 Northport Court', 'asparkwill46@stanford.edu', '2016-01-11 13:06:14'),
	(152, 'Kaia Robertacci', '6 Hoepker Terrace', 'krobertacci47@miitbeian.gov.cn', '2016-03-16 00:17:53'),
	(153, 'Minny Muncie', '9375 Memorial Avenue', 'mmuncie48@angelfire.com', '2016-06-14 08:16:30'),
	(154, 'Sadella Knowler', '3 Hoffman Way', 'sknowler49@phoca.cz', '2018-07-05 01:42:53'),
	(155, 'Muhammad MacAvddy', '36 Lyons Crossing', 'mmacavddy4a@barnesandnoble.com', '2020-10-24 20:33:51'),
	(156, 'Clemmy Claypool', '50 Meadow Valley Junction', 'cclaypool4b@dot.gov', '2019-10-27 08:12:52'),
	(157, 'Arturo January 1st', '89 Mockingbird Point', 'ajanuary4c@tmall.com', '2017-05-10 22:12:15'),
	(158, 'Juanita Formby', '98628 Morrow Parkway', 'jformby4d@vimeo.com', '2020-04-29 22:53:23'),
	(159, 'Erinn Bebis', '19 Vernon Road', 'ebebis4e@usnews.com', '2016-06-11 07:29:46'),
	(160, 'Howie Droogan', '5 Erie Point', 'hdroogan4f@scribd.com', '2020-05-21 20:32:11'),
	(161, 'Jamesy Devanny', '2 Bluejay Point', 'jdevanny4g@flickr.com', '2018-12-28 08:44:09'),
	(162, 'Doroteya Ruppert', '3 Rusk Avenue', 'druppert4h@hibu.com', '2016-04-13 19:08:49'),
	(163, 'Giselle Muller', '67310 Russell Road', 'gmuller4i@dion.ne.jp', '2017-09-29 16:46:50'),
	(164, 'Hobard Worrill', '3 Carpenter Hill', 'hworrill4j@csmonitor.com', '2017-04-01 08:18:49'),
	(165, 'Kalvin Duly', '29 Spaight Court', 'kduly4k@apache.org', '2017-04-01 04:20:49'),
	(166, 'Doug Ick', '97514 Vermont Plaza', 'dick4l@theatlantic.com', '2018-05-11 09:44:22'),
	(167, 'Boot Conner', '75034 Morningstar Parkway', 'bconner4m@dailymotion.com', '2020-09-14 07:37:33'),
	(168, 'Killian Simcoe', '88276 Montana Road', 'ksimcoe4n@booking.com', '2020-07-19 05:20:47'),
	(169, 'Alfi Cromett', '0 Fordem Junction', 'acromett4o@technorati.com', '2020-12-20 14:19:22'),
	(170, 'Yuma Sharvill', '325 Straubel Terrace', 'ysharvill4p@hud.gov', '2021-05-27 12:37:26'),
	(171, 'Weidar Woolam', '4157 Walton Road', 'wwoolam4q@imdb.com', '2019-11-03 06:07:08'),
	(172, 'Jedediah De Freyne', '7 Dexter Circle', 'jde4r@google.ca', '2021-03-02 23:37:25'),
	(173, 'Saree Fowlston', '9 Del Mar Lane', 'sfowlston4s@tinypic.com', '2015-10-18 07:14:45'),
	(174, 'Ingar Dominicacci', '255 Hoffman Point', 'idominicacci4t@digg.com', '2020-04-24 04:49:03'),
	(175, 'Wynny Stirtle', '0 Ridgeway Road', 'wstirtle4u@barnesandnoble.com', '2017-07-01 05:22:40'),
	(176, 'Wallis Maywood', '573 Dexter Point', 'wmaywood4v@chronoengine.com', '2018-01-31 18:58:03'),
	(177, 'Ring McMonnies', '651 Bay Center', 'rmcmonnies4w@state.gov', '2020-12-15 22:55:02'),
	(178, 'Rurik Stigers', '31096 Westridge Lane', 'rstigers4x@wufoo.com', '2019-09-08 23:59:37'),
	(179, 'Christalle Hainsworth', '50 Northport Parkway', 'chainsworth4y@hud.gov', '2016-05-21 02:23:00'),
	(180, 'Hugibert Clarke-Williams', '6 Mayfield Point', 'hclarkewilliams4z@blogspot.com', '2017-09-04 00:38:51'),
	(181, 'Tedd Wivell', '0582 Autumn Leaf Drive', 'twivell50@ehow.com', '2019-03-24 10:44:21'),
	(182, 'Kasper Ebbin', '21 Rigney Trail', 'kebbin51@liveinternet.ru', '2018-05-29 18:46:52'),
	(183, 'Launce Ceaplen', '0599 Spohn Junction', 'lceaplen52@live.com', '2020-12-10 20:17:06'),
	(184, 'Lorilee Goodier', '180 Warbler Alley', 'lgoodier53@live.com', '2017-01-14 18:27:41'),
	(185, 'Kara-lynn Faivre', '668 Northfield Street', 'kfaivre54@acquirethisname.com', '2021-03-17 19:53:36'),
	(186, 'Emmalynne Gwyn', '18709 Blaine Trail', 'egwyn55@vkontakte.ru', '2020-04-04 19:43:12'),
	(187, 'Jarret Gillaspy', '06 Lyons Lane', 'jgillaspy56@arizona.edu', '2019-06-23 02:13:02'),
	(188, 'Arabel Capstack', '1626 Eliot Parkway', 'acapstack57@cdbaby.com', '2017-07-09 01:35:44'),
	(189, 'Guy Micklewicz', '95633 Eggendart Way', 'gmicklewicz58@bluehost.com', '2020-12-13 20:33:35'),
	(190, 'Jennee Pavlovic', '3 Badeau Place', 'jpavlovic59@uol.com.br', '2019-04-13 06:02:06'),
	(191, 'Galvan Skews', '4390 Johnson Place', 'gskews5a@google.ca', '2015-10-07 13:45:11'),
	(192, 'Ignacius Keppy', '5 Maywood Court', 'ikeppy5b@vk.com', '2015-11-12 08:58:49'),
	(193, 'Gerianna Vint', '05 Anzinger Parkway', 'gvint5c@phpbb.com', '2019-02-03 12:05:05'),
	(194, 'Aloysius Chellingworth', '9 Elmside Court', 'achellingworth5d@un.org', '2021-04-02 18:52:56'),
	(195, 'Mala Sybe', '71075 Moulton Alley', 'msybe5e@gizmodo.com', '2017-02-17 11:50:01'),
	(196, 'Alia Mardle', '7639 Morningstar Road', 'amardle5f@shop-pro.jp', '2021-01-17 16:40:59'),
	(197, 'Gibbie Conyers', '279 Helena Lane', 'gconyers5g@webeden.co.uk', '2019-04-02 01:54:54'),
	(198, 'Shea Blaskett', '954 Esch Street', 'sblaskett5h@senate.gov', '2018-03-25 10:43:56'),
	(199, 'Antin Shout', '6 Tony Pass', 'ashout5i@hugedomains.com', '2016-05-22 13:17:15'),
	(200, 'Lauretta Snoddin', '65398 Golden Leaf Place', 'lsnoddin5j@sohu.com', '2017-09-17 15:25:08');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.extra
CREATE TABLE IF NOT EXISTS `extra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.extra: ~4 rows (ungefähr)
DELETE FROM `extra`;
/*!40000 ALTER TABLE `extra` DISABLE KEYS */;
INSERT INTO `extra` (`id`, `name`) VALUES
	(1, 'Haftpflichtversicherung'),
	(2, 'Freikilometer 750'),
	(3, 'Freikilometer 1500'),
	(4, 'Glas & Reifenschutz');
/*!40000 ALTER TABLE `extra` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.feature
CREATE TABLE IF NOT EXISTS `feature` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.feature: ~4 rows (ungefähr)
DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`id`, `name`) VALUES
	(1, 'Navigation'),
	(2, 'Klimaanlage'),
	(3, 'Automatik'),
	(4, 'Winterreifen');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.manufacturer
CREATE TABLE IF NOT EXISTS `manufacturer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.manufacturer: ~4 rows (ungefähr)
DELETE FROM `manufacturer`;
/*!40000 ALTER TABLE `manufacturer` DISABLE KEYS */;
INSERT INTO `manufacturer` (`id`, `name`) VALUES
	(1, 'BMW'),
	(2, 'Ford'),
	(3, 'Audi'),
	(4, 'VW');
/*!40000 ALTER TABLE `manufacturer` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle rental_portal.rental
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

-- Exportiere Daten aus Tabelle rental_portal.rental: ~70 rows (ungefähr)
DELETE FROM `rental`;
/*!40000 ALTER TABLE `rental` DISABLE KEYS */;
INSERT INTO `rental` (`id`, `reservation_id`, `car_id`) VALUES
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

-- Exportiere Struktur von Tabelle rental_portal.rental_station
CREATE TABLE IF NOT EXISTS `rental_station` (
  `id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.rental_station: ~20 rows (ungefähr)
DELETE FROM `rental_station`;
/*!40000 ALTER TABLE `rental_station` DISABLE KEYS */;
INSERT INTO `rental_station` (`id`, `location`) VALUES
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

-- Exportiere Struktur von Tabelle rental_portal.reservation
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
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19802 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.reservation: ~100 rows (ungefähr)
DELETE FROM `reservation`;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` (`id`, `customer_id`, `car_id`, `reserved_at`, `rent_from`, `rent_to`) VALUES
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

-- Exportiere Struktur von Tabelle rental_portal.take_back_protocol
CREATE TABLE IF NOT EXISTS `take_back_protocol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rental_id` int DEFAULT NULL,
  `cur_kilometers` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rental_id` (`rental_id`),
  CONSTRAINT `take_back_protocol_ibfk_1` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

-- Exportiere Daten aus Tabelle rental_portal.take_back_protocol: ~30 rows (ungefähr)
DELETE FROM `take_back_protocol`;
/*!40000 ALTER TABLE `take_back_protocol` DISABLE KEYS */;
INSERT INTO `take_back_protocol` (`id`, `rental_id`, `cur_kilometers`) VALUES
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
