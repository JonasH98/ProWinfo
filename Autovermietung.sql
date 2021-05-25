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

-- Exportiere Struktur von Tabelle autovermietung.automarke
DROP TABLE IF EXISTS `automarke`;
CREATE TABLE IF NOT EXISTS `automarke` (
  `markenID` int NOT NULL,
  `markenname` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`markenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.automarke: ~0 rows (ungefähr)
DELETE FROM `automarke`;
/*!40000 ALTER TABLE `automarke` DISABLE KEYS */;
/*!40000 ALTER TABLE `automarke` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.kfz
DROP TABLE IF EXISTS `kfz`;
CREATE TABLE IF NOT EXISTS `kfz` (
  `AutoID` int NOT NULL AUTO_INCREMENT,
  `Kennzeichen` varchar(50) NOT NULL DEFAULT '0',
  `Marke` int NOT NULL DEFAULT '0',
  `KFZ-Typ` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`AutoID`),
  KEY `FK_kfz_kfz-typ` (`KFZ-Typ`),
  KEY `FK_kfz_automarke` (`Marke`),
  CONSTRAINT `FK_kfz_automarke` FOREIGN KEY (`Marke`) REFERENCES `automarke` (`markenID`),
  CONSTRAINT `FK_kfz_kfz-typ` FOREIGN KEY (`KFZ-Typ`) REFERENCES `kfz-typ` (`KFZTypID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.kfz: ~0 rows (ungefähr)
DELETE FROM `kfz`;
/*!40000 ALTER TABLE `kfz` DISABLE KEYS */;
/*!40000 ALTER TABLE `kfz` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.kfz-typ
DROP TABLE IF EXISTS `kfz-typ`;
CREATE TABLE IF NOT EXISTS `kfz-typ` (
  `KFZTypID` int NOT NULL AUTO_INCREMENT,
  `KfzKlasse` int NOT NULL DEFAULT '0',
  `Türen` enum('2-3','4-5') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Sitze` enum('2-3','4-5','6-7','8-9') DEFAULT NULL,
  `Navigation` enum('Y','N') DEFAULT NULL,
  `Klimaanlage` enum('Y','N') DEFAULT NULL,
  `Automatik` enum('Y','N') DEFAULT NULL,
  `Winterreifen` enum('Y','N') DEFAULT NULL,
  `Haftpflicht` enum('Y','N') DEFAULT NULL,
  `Freikilometer` enum('750','1500') DEFAULT NULL,
  `Glas-&Reifenschutz` enum('Y','N') DEFAULT NULL,
  `Zweifahreroption` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`KFZTypID`),
  KEY `FK_kfz-typ_kfzklasse` (`KfzKlasse`),
  CONSTRAINT `FK_kfz-typ_kfzklasse` FOREIGN KEY (`KfzKlasse`) REFERENCES `kfzklasse` (`KfzKlassenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.kfz-typ: ~0 rows (ungefähr)
DELETE FROM `kfz-typ`;
/*!40000 ALTER TABLE `kfz-typ` DISABLE KEYS */;
/*!40000 ALTER TABLE `kfz-typ` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.kfzklasse
DROP TABLE IF EXISTS `kfzklasse`;
CREATE TABLE IF NOT EXISTS `kfzklasse` (
  `KfzKlassenID` int NOT NULL AUTO_INCREMENT,
  `Kfzklassenname` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`KfzKlassenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.kfzklasse: ~0 rows (ungefähr)
DELETE FROM `kfzklasse`;
/*!40000 ALTER TABLE `kfzklasse` DISABLE KEYS */;
/*!40000 ALTER TABLE `kfzklasse` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.kunde
DROP TABLE IF EXISTS `kunde`;
CREATE TABLE IF NOT EXISTS `kunde` (
  `KundenID` int NOT NULL AUTO_INCREMENT,
  `Nachname` varchar(50) NOT NULL DEFAULT '0',
  `Vorname` varchar(50) NOT NULL DEFAULT '0',
  `Adresse` varchar(50) NOT NULL DEFAULT '0',
  `Passwort` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`KundenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.kunde: ~0 rows (ungefähr)
DELETE FROM `kunde`;
/*!40000 ALTER TABLE `kunde` DISABLE KEYS */;
/*!40000 ALTER TABLE `kunde` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.mietstation
DROP TABLE IF EXISTS `mietstation`;
CREATE TABLE IF NOT EXISTS `mietstation` (
  `MietstationID` int NOT NULL AUTO_INCREMENT,
  `Ort` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`MietstationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.mietstation: ~0 rows (ungefähr)
DELETE FROM `mietstation`;
/*!40000 ALTER TABLE `mietstation` DISABLE KEYS */;
/*!40000 ALTER TABLE `mietstation` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.reservierung
DROP TABLE IF EXISTS `reservierung`;
CREATE TABLE IF NOT EXISTS `reservierung` (
  `reservierungsID` int NOT NULL AUTO_INCREMENT,
  `kunde` int NOT NULL DEFAULT '0',
  `kfz` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`reservierungsID`),
  KEY `FK__kunderes` (`kunde`),
  KEY `FK__kfzres` (`kfz`),
  CONSTRAINT `FK__kfzres` FOREIGN KEY (`kfz`) REFERENCES `kfz` (`AutoID`),
  CONSTRAINT `FK__kunderes` FOREIGN KEY (`kunde`) REFERENCES `kunde` (`KundenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.reservierung: ~0 rows (ungefähr)
DELETE FROM `reservierung`;
/*!40000 ALTER TABLE `reservierung` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservierung` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.ruecknahmeprotokoll
DROP TABLE IF EXISTS `ruecknahmeprotokoll`;
CREATE TABLE IF NOT EXISTS `ruecknahmeprotokoll` (
  `ruecknahmeID` int NOT NULL AUTO_INCREMENT,
  `kfz` int NOT NULL DEFAULT '0',
  `kunde` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ruecknahmeID`),
  KEY `FK__kfz` (`kfz`),
  KEY `FK__kunde` (`kunde`),
  CONSTRAINT `FK__kfz` FOREIGN KEY (`kfz`) REFERENCES `kfz` (`AutoID`),
  CONSTRAINT `FK__kunde` FOREIGN KEY (`kunde`) REFERENCES `kunde` (`KundenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.ruecknahmeprotokoll: ~0 rows (ungefähr)
DELETE FROM `ruecknahmeprotokoll`;
/*!40000 ALTER TABLE `ruecknahmeprotokoll` DISABLE KEYS */;
/*!40000 ALTER TABLE `ruecknahmeprotokoll` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.tarif
DROP TABLE IF EXISTS `tarif`;
CREATE TABLE IF NOT EXISTS `tarif` (
  `TarifID` int NOT NULL AUTO_INCREMENT,
  `Tarifname` varchar(50) DEFAULT NULL,
  `Preis` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`TarifID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.tarif: ~0 rows (ungefähr)
DELETE FROM `tarif`;
/*!40000 ALTER TABLE `tarif` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarif` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle autovermietung.vermietung
DROP TABLE IF EXISTS `vermietung`;
CREATE TABLE IF NOT EXISTS `vermietung` (
  `vermietungsID` int NOT NULL AUTO_INCREMENT,
  `kfz` int NOT NULL DEFAULT '0',
  `mietstation` int NOT NULL DEFAULT '0',
  `tarif` int NOT NULL DEFAULT '0',
  `kunde` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`vermietungsID`),
  KEY `FK__kfzver` (`kfz`),
  KEY `FK__kundever` (`kunde`),
  KEY `FK__mietstation` (`mietstation`),
  KEY `FK__tarif` (`tarif`),
  CONSTRAINT `FK__kfzver` FOREIGN KEY (`kfz`) REFERENCES `kfz` (`AutoID`),
  CONSTRAINT `FK__kundever` FOREIGN KEY (`kunde`) REFERENCES `kunde` (`KundenID`),
  CONSTRAINT `FK__mietstation` FOREIGN KEY (`mietstation`) REFERENCES `mietstation` (`MietstationID`),
  CONSTRAINT `FK__tarif` FOREIGN KEY (`tarif`) REFERENCES `tarif` (`TarifID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Exportiere Daten aus Tabelle autovermietung.vermietung: ~0 rows (ungefähr)
DELETE FROM `vermietung`;
/*!40000 ALTER TABLE `vermietung` DISABLE KEYS */;
/*!40000 ALTER TABLE `vermietung` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
