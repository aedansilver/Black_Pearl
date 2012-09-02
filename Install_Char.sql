-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.9-log - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2012-09-02 13:07:21
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping structure for table char.blackpearl_battle
DROP TABLE IF EXISTS `blackpearl_battle`;
CREATE TABLE IF NOT EXISTS `blackpearl_battle` (
  `index` int(100) NOT NULL,
  `character` varchar(100) DEFAULT NULL,
  `damageDone` int(11) DEFAULT NULL,
  `healDone` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table char.blackpearl_queue
DROP TABLE IF EXISTS `blackpearl_queue`;
CREATE TABLE IF NOT EXISTS `blackpearl_queue` (
  `AccName` varchar(100) DEFAULT NULL,
  `Character` varchar(100) DEFAULT NULL,
  `faction` varchar(100) DEFAULT 'unknown',
  UNIQUE KEY `AccName` (`AccName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.


-- Dumping structure for table char.blackpearl_status
DROP TABLE IF EXISTS `blackpearl_status`;
CREATE TABLE IF NOT EXISTS `blackpearl_status` (
  `Active` int(10) DEFAULT '0' COMMENT '0: battle avaible, 1: battle in progress',
  `last_played` varchar(100) DEFAULT 'never',
  `matches_played` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
