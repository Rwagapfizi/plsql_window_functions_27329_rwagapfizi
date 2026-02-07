-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: PL_SQL_ASSIGNMENT1
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `registration_date` date NOT NULL,
  `region_id` int(11) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `customer_segment` varchar(20) DEFAULT 'Standard',
  `total_purchases` decimal(10,2) DEFAULT 0.00,
  `last_purchase_date` date DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES
(1,'Eric','Ndahiro','eric@email.rw','2024-01-01',1,'Remera','Standard',349.98,'2024-03-10'),
(2,'Marie','Uwamahoro','marie@email.rw','2024-01-15',2,'Gikondo','Standard',289.97,'2024-03-15'),
(3,'Jean','Baptiste','jean@email.rw','2024-02-01',3,'Musanze Town','Standard',199.99,'2024-02-10'),
(4,'Chantal','Mukamana','chantal@email.rw','2024-02-15',1,'Kimironko','Standard',39.99,'2024-02-15'),
(5,'Samuel','Twahirwa','samuel@email.rw','2024-03-01',4,'Rubavu Town','Standard',349.97,'2024-03-05'),
(6,'Annette','Uwimana','annette@email.rw','2024-03-15',2,'Kicukiro','Standard',129.98,'2024-03-20');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_detail` (
  `order_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL CHECK (`quantity` > 0),
  `unit_price` decimal(10,2) NOT NULL,
  `line_total` decimal(10,2) DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`order_detail_id`),
  KEY `product_id` (`product_id`),
  KEY `idx_order_product` (`order_id`,`product_id`),
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES
(1,1,1,1,299.99,299.99,0.00),
(2,2,2,1,39.99,39.99,0.00),
(3,2,3,5,9.99,49.95,0.00),
(4,3,5,1,199.99,199.99,0.00),
(5,4,2,1,39.99,39.99,0.00),
(6,5,1,1,299.99,299.99,0.00),
(7,5,4,1,49.99,49.99,0.00),
(8,6,3,5,9.99,49.95,0.00),
(9,7,5,1,199.99,199.99,0.00),
(10,8,2,2,39.99,79.98,0.00),
(11,8,3,5,9.99,49.95,0.00);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER calculate_line_total
BEFORE INSERT ON ORDER_DETAIL
FOR EACH ROW
BEGIN
    SET NEW.line_total = NEW.quantity * NEW.unit_price * (1 - COALESCE(NEW.discount_percentage, 0) / 100);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT 'Completed' CHECK (`status` in ('Pending','Processing','Shipped','Delivered','Cancelled','Completed')),
  `payment_method` varchar(30) DEFAULT NULL,
  `order_month` varchar(7) DEFAULT NULL,
  `shipping_district` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `idx_order_date` (`order_date`),
  KEY `idx_customer_order` (`customer_id`,`order_date`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(1,1,'2024-01-20',299.99,'Completed','Mobile Money','2024-01','Remera'),
(2,2,'2024-01-25',89.98,'Completed','Bank Transfer','2024-01','Gikondo'),
(3,3,'2024-02-10',199.99,'Completed','Mobile Money','2024-02','Musanze Town'),
(4,4,'2024-02-15',39.99,'Completed','Credit Card','2024-02','Kimironko'),
(5,5,'2024-03-05',349.97,'Completed','Mobile Money','2024-03','Rubavu Town'),
(6,1,'2024-03-10',49.99,'Completed','Bank Transfer','2024-03','Remera'),
(7,2,'2024-03-15',199.99,'Completed','Mobile Money','2024-03','Gikondo'),
(8,6,'2024-03-20',129.98,'Completed','Credit Card','2024-03','Kicukiro');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER set_order_month
BEFORE INSERT ON ORDERS
FOR EACH ROW
BEGIN
    SET NEW.order_month = DATE_FORMAT(NEW.order_date, '%Y-%m');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) DEFAULT 0,
  `sustainability_rating` char(1) DEFAULT NULL CHECK (`sustainability_rating` in ('A','B','C','D','E')),
  `is_active` tinyint(1) DEFAULT 1,
  `rwf_price` int(11) GENERATED ALWAYS AS (`price` * 1300) VIRTUAL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `product_name` (`product_name`,`brand`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES
(1,'Solar Home System','Energy','GreenTech',299.99,180.00,0,'A',1,389987),
(2,'Solar Phone Charger','Accessories','Mara Solar',39.99,20.00,0,'B',1,51987),
(3,'Energy Saving Bulbs','Lighting','EcoLight',9.99,4.00,0,'A',1,12987),
(4,'Solar Radio','Electronics','Kigali Tech',49.99,25.00,0,'B',1,64987),
(5,'Biogas Cooker','Kitchen','GreenHome',199.99,120.00,0,'A',1,259987);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `region_name` varchar(50) NOT NULL,
  `province` varchar(50) NOT NULL,
  `manager_name` varchar(100) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES
(1,'Gasabo','Kigali','Alice Uwase','2026-02-06 08:51:45'),
(2,'Kicukiro','Kigali','David Habimana','2026-02-06 08:51:45'),
(3,'Musanze','Northern','Eric Tuyishime','2026-02-06 08:51:45'),
(4,'Rubavu','Western','Chantal Uwimana','2026-02-06 08:51:45');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-07 15:38:25
