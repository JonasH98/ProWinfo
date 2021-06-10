--DATABASE NAME SHOULD BE "rental_portal"

CREATE TABLE `customer` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `full_name` varchar(255),
  `address` varchar(255),
  `email` varchar(255),
  `created_at` datetime
);

CREATE TABLE `car` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `rental_station_id` int,
  `car_type_id` int,
  `manufacturer_id` int,
  `image_url` varchar(255)
);

CREATE TABLE `car_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `seats` int,
  `doors` int
);

CREATE TABLE `car_type_feature` (
  `car_type_id` int,
  `feature_id` int
);

CREATE TABLE `car_type_extra` (
  `car_type_id` int,
  `extra_id` int
);

CREATE TABLE `car_type_class` (
  `car_type_id` int,
  `car_class_id` int
);

CREATE TABLE `car_class` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `feature` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `extra` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `manufacturer` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `rental_station` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `location` varchar(255)
);

CREATE TABLE `reservation` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `customer_id` int,
  `car_type_id` int,
  `reserved_at` datetime,
  `rent_from` datetime,
  `rent_to` datetime
);

CREATE TABLE `rental` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `reservation_id` int,
  `car_id` int
);

CREATE TABLE `take_back_protocol` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `rental_id` int,
  `cur_kilometers` int
);

ALTER TABLE `car` ADD FOREIGN KEY (`rental_station_id`) REFERENCES `rental_station` (`id`);

ALTER TABLE `car` ADD FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`);

ALTER TABLE `car` ADD FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`);

ALTER TABLE `car_type_feature` ADD FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`);

ALTER TABLE `car_type_feature` ADD FOREIGN KEY (`feature_id`) REFERENCES `feature` (`id`);

ALTER TABLE `car_type_extra` ADD FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`);

ALTER TABLE `car_type_extra` ADD FOREIGN KEY (`extra_id`) REFERENCES `extra` (`id`);

ALTER TABLE `car_type_class` ADD FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`);

ALTER TABLE `car_type_class` ADD FOREIGN KEY (`car_class_id`) REFERENCES `car_class` (`id`);

ALTER TABLE `reservation` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

ALTER TABLE `reservation` ADD FOREIGN KEY (`car_type_id`) REFERENCES `car_type` (`id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`car_id`) REFERENCES `car` (`id`);

ALTER TABLE `take_back_protocol` ADD FOREIGN KEY (`rental_id`) REFERENCES `rental` (`id`);
