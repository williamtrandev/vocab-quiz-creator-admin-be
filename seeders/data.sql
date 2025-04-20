-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: vocabulary_db
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `question_sets`
--

DROP TABLE IF EXISTS `question_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_sets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `level` enum('beginner','elementary','intermediate','advanced','expert') NOT NULL,
  `totalQuestions` int NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_sets`
--

LOCK TABLES `question_sets` WRITE;
/*!40000 ALTER TABLE `question_sets` DISABLE KEYS */;
INSERT INTO `question_sets` VALUES (2,'Basic English Vocabulary Quiz','A quiz to test your basic English vocabulary knowledge','beginner',10,'2025-04-12 21:10:27','2025-04-12 21:10:27'),(3,'Beginner English Vocabulary Quiz 2','More basic English words for beginners','beginner',5,'2025-04-12 21:13:52','2025-04-12 21:13:52'),(4,'Elementary English Vocabulary Quiz 1','Basic time-related vocabulary','elementary',5,'2025-04-12 21:14:05','2025-04-12 21:14:05'),(5,'Elementary English Vocabulary Quiz 2','Basic nature and environment vocabulary','elementary',5,'2025-04-12 21:14:13','2025-04-12 21:14:13'),(6,'Intermediate English Vocabulary Quiz 1','Communication and education vocabulary','intermediate',5,'2025-04-12 21:14:22','2025-04-12 21:14:22'),(7,'Advanced English Vocabulary Quiz 1','Achievement and capability vocabulary','advanced',5,'2025-04-12 21:14:48','2025-04-12 21:14:48'),(8,'Advanced English Vocabulary Quiz 2','Professional and leadership vocabulary','advanced',5,'2025-04-12 21:14:54','2025-04-12 21:14:54'),(9,'Expert English Vocabulary Quiz 1','Advanced personality traits vocabulary','expert',5,'2025-04-12 21:15:02','2025-04-12 21:15:02'),(10,'Expert English Vocabulary Quiz 2','Advanced character traits vocabulary','expert',5,'2025-04-12 21:15:07','2025-04-12 21:15:07'),(11,'Thanh Chan','Just for testing','beginner',2,'2025-04-16 20:13:31','2025-04-16 20:13:31');
/*!40000 ALTER TABLE `question_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `questionSetId` int NOT NULL,
  `vocabularyId` int NOT NULL,
  `correctAnswer` varchar(255) NOT NULL,
  `wrongAnswer1` varchar(255) NOT NULL,
  `wrongAnswer2` varchar(255) NOT NULL,
  `wrongAnswer3` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `questionSetId` (`questionSetId`),
  KEY `vocabularyId` (`vocabularyId`),
  CONSTRAINT `questions_ibfk_245` FOREIGN KEY (`questionSetId`) REFERENCES `question_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `questions_ibfk_246` FOREIGN KEY (`vocabularyId`) REFERENCES `vocabulary` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (3,2,13,'xin chào','tạm biệt','cảm ơn','làm ơn','2025-04-12 21:10:27','2025-04-12 21:10:27'),(4,2,15,'cảm ơn','xin lỗi','làm ơn','tạm biệt','2025-04-12 21:10:27','2025-04-12 21:10:27'),(5,2,14,'tạm biệt','xin chào','cảm ơn','xin lỗi','2025-04-12 21:10:27','2025-04-12 21:10:27'),(6,2,17,'có','không','xin lỗi','cảm ơn','2025-04-12 21:10:27','2025-04-12 21:10:27'),(7,2,16,'làm ơn','cảm ơn','xin lỗi','tạm biệt','2025-04-12 21:10:27','2025-04-12 21:10:27'),(8,2,18,'không','có','xin lỗi','cảm ơn','2025-04-12 21:10:27','2025-04-12 21:10:27'),(9,2,19,'xin lỗi','cảm ơn','làm ơn','tạm biệt','2025-04-12 21:10:27','2025-04-12 21:10:27'),(10,2,21,'tuổi','tên','thời gian','ngày','2025-04-12 21:10:27','2025-04-12 21:10:27'),(11,2,20,'tên','tuổi','thời gian','ngày','2025-04-12 21:10:27','2025-04-12 21:10:27'),(12,2,22,'thời gian','ngày','đêm','tuổi','2025-04-12 21:10:27','2025-04-12 21:10:27'),(13,3,18,'không','có','xin lỗi','cảm ơn','2025-04-12 21:13:52','2025-04-12 21:13:52'),(14,3,19,'xin lỗi','cảm ơn','làm ơn','tạm biệt','2025-04-12 21:13:52','2025-04-12 21:13:52'),(15,3,20,'tên','tuổi','thời gian','ngày','2025-04-12 21:13:52','2025-04-12 21:13:52'),(16,3,21,'tuổi','tên','thời gian','ngày','2025-04-12 21:13:52','2025-04-12 21:13:52'),(17,3,22,'thời gian','ngày','đêm','tuổi','2025-04-12 21:13:52','2025-04-12 21:13:52'),(18,4,33,'buổi sáng','buổi chiều','buổi tối','tuần','2025-04-12 21:14:05','2025-04-12 21:14:05'),(19,4,34,'buổi chiều','buổi sáng','buổi tối','tháng','2025-04-12 21:14:05','2025-04-12 21:14:05'),(20,4,37,'tháng','tuần','năm','buổi chiều','2025-04-12 21:14:05','2025-04-12 21:14:05'),(21,4,36,'tuần','tháng','năm','buổi sáng','2025-04-12 21:14:05','2025-04-12 21:14:05'),(22,4,35,'buổi tối','buổi sáng','buổi chiều','năm','2025-04-12 21:14:05','2025-04-12 21:14:05'),(23,5,38,'năm','tuần','tháng','buổi tối','2025-04-12 21:14:13','2025-04-12 21:14:13'),(24,5,39,'thời tiết','mùa','màu sắc','số','2025-04-12 21:14:13','2025-04-12 21:14:13'),(25,5,40,'mùa','thời tiết','màu sắc','số','2025-04-12 21:14:13','2025-04-12 21:14:13'),(26,5,42,'số','thời tiết','mùa','màu sắc','2025-04-12 21:14:13','2025-04-12 21:14:13'),(27,5,41,'màu sắc','thời tiết','mùa','số','2025-04-12 21:14:13','2025-04-12 21:14:13'),(28,6,53,'giao tiếp','giáo dục','môi trường','công nghệ','2025-04-12 21:14:22','2025-04-12 21:14:22'),(29,6,54,'giáo dục','giao tiếp','môi trường','công nghệ','2025-04-12 21:14:22','2025-04-12 21:14:22'),(30,6,55,'môi trường','giao tiếp','giáo dục','công nghệ','2025-04-12 21:14:22','2025-04-12 21:14:22'),(31,6,56,'công nghệ','giao tiếp','giáo dục','môi trường','2025-04-12 21:14:22','2025-04-12 21:14:22'),(32,6,57,'kinh doanh','giao tiếp','giáo dục','môi trường','2025-04-12 21:14:22','2025-04-12 21:14:22'),(33,7,73,'thành tựu','thành tích','tham vọng','khát vọng','2025-04-12 21:14:48','2025-04-12 21:14:48'),(34,7,74,'thành tích','thành tựu','tham vọng','khát vọng','2025-04-12 21:14:48','2025-04-12 21:14:48'),(35,7,77,'năng lực','thành tựu','thành tích','tham vọng','2025-04-12 21:14:48','2025-04-12 21:14:48'),(36,7,76,'khát vọng','thành tựu','thành tích','tham vọng','2025-04-12 21:14:48','2025-04-12 21:14:48'),(37,7,75,'tham vọng','thành tựu','thành tích','khát vọng','2025-04-12 21:14:48','2025-04-12 21:14:48'),(38,8,78,'năng lực','quyết tâm','siêng năng','xuất sắc','2025-04-12 21:14:54','2025-04-12 21:14:54'),(39,8,79,'quyết tâm','năng lực','siêng năng','xuất sắc','2025-04-12 21:14:54','2025-04-12 21:14:54'),(40,8,80,'siêng năng','năng lực','quyết tâm','xuất sắc','2025-04-12 21:14:54','2025-04-12 21:14:54'),(41,8,82,'chuyên môn','năng lực','quyết tâm','siêng năng','2025-04-12 21:14:54','2025-04-12 21:14:54'),(42,8,81,'xuất sắc','năng lực','quyết tâm','siêng năng','2025-04-12 21:14:54','2025-04-12 21:14:54'),(43,9,93,'tiết chế','nhân từ','thận trọng','sáng suốt','2025-04-12 21:15:02','2025-04-12 21:15:02'),(44,9,94,'nhân từ','tiết chế','thận trọng','sáng suốt','2025-04-12 21:15:02','2025-04-12 21:15:02'),(45,9,95,'thận trọng','tiết chế','nhân từ','sáng suốt','2025-04-12 21:15:02','2025-04-12 21:15:02'),(46,9,96,'sáng suốt','tiết chế','nhân từ','thận trọng','2025-04-12 21:15:02','2025-04-12 21:15:02'),(47,9,97,'bình tĩnh','tiết chế','nhân từ','thận trọng','2025-04-12 21:15:02','2025-04-12 21:15:02'),(48,10,98,'kỹ tính','hòa đồng','khiêm tốn','bất khuất','2025-04-12 21:15:07','2025-04-12 21:15:07'),(49,10,99,'hòa đồng','kỹ tính','khiêm tốn','bất khuất','2025-04-12 21:15:07','2025-04-12 21:15:07'),(50,10,100,'khiêm tốn','kỹ tính','hòa đồng','bất khuất','2025-04-12 21:15:07','2025-04-12 21:15:07'),(51,10,101,'bất khuất','kỹ tính','hòa đồng','khiêm tốn','2025-04-12 21:15:07','2025-04-12 21:15:07'),(52,10,102,'sáng suốt','kỹ tính','hòa đồng','khiêm tốn','2025-04-12 21:15:07','2025-04-12 21:15:07'),(53,11,13,'xin chào','không','có','sai','2025-04-16 20:13:31','2025-04-16 20:13:31'),(54,11,14,'tạm biệt','chào','đi','ngủ','2025-04-16 20:13:31','2025-04-16 20:13:31');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequelizemeta` (
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequelizemeta`
--

LOCK TABLES `sequelizemeta` WRITE;
/*!40000 ALTER TABLE `sequelizemeta` DISABLE KEYS */;
INSERT INTO `sequelizemeta` VALUES ('20240412000000-create-vocabulary.js'),('20240412000001-create-question-sets.js'),('20240412000002-create-questions.js'),('20240412000003-create-users.js'),('20240412000004-create-user-vocabulary.js'),('20240412000005-add-column-vocabulary.js'),('20240412000006-create-topics.js');
/*!40000 ALTER TABLE `sequelizemeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `level` enum('beginner','elementary','intermediate','advanced','expert') NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,'Food and Drinks','Vocabulary related to food and drinks','elementary','2025-04-16 18:13:48','2025-04-16 18:13:48'),(2,'Greetings','Vocabulary related to greetings','elementary','2025-04-16 23:23:47','2025-04-16 23:23:47'),(3,'Level 1','Level 1 Topic','beginner','2025-04-17 20:42:07','2025-04-17 20:42:07'),(4,'Level 3','Level 3 Topic','intermediate','2025-04-17 20:42:18','2025-04-17 20:42:18'),(5,'Level 4','Level 4 Topic','advanced','2025-04-17 20:42:39','2025-04-17 20:42:39'),(6,'Level 5','Level 5 Topic','expert','2025-04-17 20:42:50','2025-04-17 20:42:50'),(7,'Level 1 Continue','','beginner','2025-04-17 21:01:23','2025-04-17 21:01:23'),(9,'Level 3 Continue','','intermediate','2025-04-17 21:01:38','2025-04-17 21:01:38'),(10,'Level 4 Continue','','advanced','2025-04-17 21:01:46','2025-04-17 21:01:46'),(12,'Level 5 Continue','','expert','2025-04-17 21:16:14','2025-04-17 21:16:14');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_vocabulary`
--

DROP TABLE IF EXISTS `user_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `vocabularyId` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_vocabulary` (`userId`,`vocabularyId`),
  KEY `vocabularyId` (`vocabularyId`),
  CONSTRAINT `user_vocabulary_ibfk_57` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_vocabulary_ibfk_58` FOREIGN KEY (`vocabularyId`) REFERENCES `vocabulary` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_vocabulary`
--

LOCK TABLES `user_vocabulary` WRITE;
/*!40000 ALTER TABLE `user_vocabulary` DISABLE KEYS */;
INSERT INTO `user_vocabulary` VALUES (2,3,13,'2025-04-15 14:34:02','2025-04-15 14:34:02'),(3,4,13,'2025-04-15 16:21:38','2025-04-15 16:21:38'),(4,4,17,'2025-04-15 17:02:53','2025-04-15 17:02:53'),(5,3,14,'2025-04-15 23:42:00','2025-04-15 23:42:00'),(6,3,33,'2025-04-17 16:39:57','2025-04-17 16:39:57'),(7,4,43,'2025-04-18 23:30:30','2025-04-18 23:30:30'),(8,4,45,'2025-04-18 23:30:55','2025-04-18 23:30:55'),(9,4,44,'2025-04-19 00:11:16','2025-04-19 00:11:16'),(11,4,46,'2025-04-19 00:29:22','2025-04-19 00:29:22'),(12,4,47,'2025-04-19 00:29:35','2025-04-19 00:29:35'),(13,4,48,'2025-04-19 00:29:40','2025-04-19 00:29:40'),(14,4,50,'2025-04-19 00:30:03','2025-04-19 00:30:03'),(16,4,52,'2025-04-19 00:30:19','2025-04-19 00:30:19'),(17,4,49,'2025-04-19 19:13:34','2025-04-19 19:13:34'),(18,4,51,'2025-04-19 19:13:35','2025-04-19 19:13:35'),(19,4,33,'2025-04-19 19:14:04','2025-04-19 19:14:04'),(20,4,35,'2025-04-19 19:14:10','2025-04-19 19:14:10'),(21,4,34,'2025-04-19 19:14:50','2025-04-19 19:14:50'),(22,4,36,'2025-04-19 19:14:51','2025-04-19 19:14:51'),(23,4,37,'2025-04-19 19:14:51','2025-04-19 19:14:51'),(24,4,38,'2025-04-19 19:14:52','2025-04-19 19:14:52'),(25,4,39,'2025-04-19 19:14:53','2025-04-19 19:14:53'),(26,4,40,'2025-04-19 19:14:53','2025-04-19 19:14:53'),(27,4,41,'2025-04-19 19:14:54','2025-04-19 19:14:54'),(28,4,42,'2025-04-19 19:14:55','2025-04-19 19:14:55'),(29,4,63,'2025-04-19 20:38:51','2025-04-19 20:38:51'),(30,4,64,'2025-04-19 20:38:52','2025-04-19 20:38:52'),(31,4,65,'2025-04-19 20:38:53','2025-04-19 20:38:53'),(32,4,66,'2025-04-19 20:38:53','2025-04-19 20:38:53'),(33,4,67,'2025-04-19 20:38:54','2025-04-19 20:38:54'),(34,4,68,'2025-04-19 20:38:55','2025-04-19 20:38:55'),(35,4,69,'2025-04-19 20:38:56','2025-04-19 20:38:56'),(36,4,70,'2025-04-19 20:38:57','2025-04-19 20:38:57'),(37,4,71,'2025-04-19 20:38:58','2025-04-19 20:38:58'),(38,4,72,'2025-04-19 20:38:59','2025-04-19 20:38:59'),(39,4,53,'2025-04-19 20:39:08','2025-04-19 20:39:08'),(40,4,54,'2025-04-19 20:39:09','2025-04-19 20:39:09'),(41,4,55,'2025-04-19 20:39:10','2025-04-19 20:39:10'),(42,4,56,'2025-04-19 20:39:11','2025-04-19 20:39:11'),(43,4,57,'2025-04-19 20:39:11','2025-04-19 20:39:11'),(44,4,58,'2025-04-19 20:39:12','2025-04-19 20:39:12'),(45,4,59,'2025-04-19 20:39:13','2025-04-19 20:39:13'),(46,4,60,'2025-04-19 20:39:14','2025-04-19 20:39:14'),(47,4,61,'2025-04-19 20:39:14','2025-04-19 20:39:14'),(48,4,62,'2025-04-19 20:39:15','2025-04-19 20:39:15'),(49,4,73,'2025-04-19 23:00:10','2025-04-19 23:00:10'),(50,4,74,'2025-04-19 23:00:12','2025-04-19 23:00:12'),(51,4,75,'2025-04-19 23:00:13','2025-04-19 23:00:13'),(52,4,76,'2025-04-19 23:00:13','2025-04-19 23:00:13'),(54,4,81,'2025-04-19 23:01:05','2025-04-19 23:01:05'),(55,4,83,'2025-04-19 23:10:38','2025-04-19 23:10:38'),(56,4,84,'2025-04-19 23:10:43','2025-04-19 23:10:43'),(57,4,85,'2025-04-19 23:10:44','2025-04-19 23:10:44'),(58,4,86,'2025-04-19 23:10:45','2025-04-19 23:10:45'),(59,4,87,'2025-04-19 23:10:45','2025-04-19 23:10:45'),(60,4,88,'2025-04-19 23:10:46','2025-04-19 23:10:46'),(61,4,89,'2025-04-19 23:10:47','2025-04-19 23:10:47'),(62,4,90,'2025-04-19 23:10:47','2025-04-19 23:10:47'),(63,4,91,'2025-04-19 23:10:48','2025-04-19 23:10:48'),(64,4,92,'2025-04-19 23:10:49','2025-04-19 23:10:49'),(65,4,82,'2025-04-19 23:12:37','2025-04-19 23:12:37'),(66,4,80,'2025-04-19 23:12:38','2025-04-19 23:12:38'),(67,4,79,'2025-04-19 23:12:45','2025-04-19 23:12:45'),(68,4,77,'2025-04-19 23:12:47','2025-04-19 23:12:47'),(69,4,78,'2025-04-19 23:12:48','2025-04-19 23:12:48'),(161,6,23,'2025-04-20 17:06:53','2025-04-20 17:06:53'),(162,6,24,'2025-04-20 17:07:17','2025-04-20 17:07:17'),(163,6,25,'2025-04-20 17:07:26','2025-04-20 17:07:26'),(164,6,26,'2025-04-20 17:07:40','2025-04-20 17:07:40'),(165,6,27,'2025-04-20 17:07:58','2025-04-20 17:07:58'),(166,6,13,'2025-04-20 17:11:33','2025-04-20 17:11:33'),(167,6,14,'2025-04-20 17:11:39','2025-04-20 17:11:39'),(168,6,15,'2025-04-20 17:11:45','2025-04-20 17:11:45'),(169,6,16,'2025-04-20 17:11:50','2025-04-20 17:11:50'),(170,6,28,'2025-04-20 17:12:57','2025-04-20 17:12:57'),(171,6,29,'2025-04-20 17:13:02','2025-04-20 17:13:02'),(172,6,30,'2025-04-20 17:13:07','2025-04-20 17:13:07'),(173,6,31,'2025-04-20 17:13:12','2025-04-20 17:13:12'),(174,6,32,'2025-04-20 17:13:18','2025-04-20 17:13:18'),(175,4,103,'2025-04-20 17:13:59','2025-04-20 17:13:59'),(176,6,17,'2025-04-20 17:15:00','2025-04-20 17:15:00'),(177,6,18,'2025-04-20 17:15:04','2025-04-20 17:15:04'),(178,6,19,'2025-04-20 17:15:10','2025-04-20 17:15:10'),(179,6,20,'2025-04-20 17:15:15','2025-04-20 17:15:15'),(180,6,21,'2025-04-20 17:15:24','2025-04-20 17:15:24'),(181,6,22,'2025-04-20 17:15:29','2025-04-20 17:15:29'),(182,6,43,'2025-04-20 17:20:00','2025-04-20 17:20:00'),(183,6,44,'2025-04-20 17:20:02','2025-04-20 17:20:02'),(184,6,45,'2025-04-20 17:21:11','2025-04-20 17:21:11'),(185,6,46,'2025-04-20 17:21:17','2025-04-20 17:21:17'),(186,6,47,'2025-04-20 17:21:29','2025-04-20 17:21:29'),(187,6,48,'2025-04-20 17:21:43','2025-04-20 17:21:43'),(188,6,49,'2025-04-20 17:21:55','2025-04-20 17:21:55'),(189,6,50,'2025-04-20 17:22:10','2025-04-20 17:22:10'),(190,6,51,'2025-04-20 17:22:18','2025-04-20 17:22:18'),(191,6,52,'2025-04-20 17:22:25','2025-04-20 17:22:25'),(192,6,33,'2025-04-20 17:22:43','2025-04-20 17:22:43'),(193,6,34,'2025-04-20 17:22:44','2025-04-20 17:22:44'),(194,6,35,'2025-04-20 17:22:45','2025-04-20 17:22:45'),(195,6,36,'2025-04-20 17:22:46','2025-04-20 17:22:46'),(196,6,37,'2025-04-20 17:22:47','2025-04-20 17:22:47'),(197,6,38,'2025-04-20 17:22:48','2025-04-20 17:22:48'),(198,6,39,'2025-04-20 17:22:49','2025-04-20 17:22:49'),(199,6,40,'2025-04-20 17:22:50','2025-04-20 17:22:50'),(200,6,41,'2025-04-20 17:22:51','2025-04-20 17:22:51'),(201,6,42,'2025-04-20 17:22:52','2025-04-20 17:22:52'),(202,6,63,'2025-04-20 17:23:31','2025-04-20 17:23:31'),(203,6,64,'2025-04-20 17:23:32','2025-04-20 17:23:32'),(204,6,65,'2025-04-20 17:23:32','2025-04-20 17:23:32'),(205,6,66,'2025-04-20 17:23:33','2025-04-20 17:23:33'),(206,6,67,'2025-04-20 17:23:34','2025-04-20 17:23:34'),(207,6,68,'2025-04-20 17:23:35','2025-04-20 17:23:35'),(208,6,69,'2025-04-20 17:23:35','2025-04-20 17:23:35'),(209,6,70,'2025-04-20 17:23:36','2025-04-20 17:23:36'),(210,6,71,'2025-04-20 17:23:37','2025-04-20 17:23:37'),(211,6,72,'2025-04-20 17:23:37','2025-04-20 17:23:37'),(212,6,53,'2025-04-20 17:23:50','2025-04-20 17:23:50'),(213,4,104,'2025-04-20 17:57:36','2025-04-20 17:57:36'),(214,4,105,'2025-04-20 19:38:21','2025-04-20 19:38:21'),(215,4,106,'2025-04-20 19:48:27','2025-04-20 19:48:27');
/*!40000 ALTER TABLE `user_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','learner') NOT NULL DEFAULT 'learner',
  `level` enum('beginner','elementary','intermediate','advanced','expert') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Doe Updated','johndoe','$2b$10$9pvA0iA1dw5JeyWkU3upsunoUd2Fivs1DJEx2oZ8d12DfI8AXzfRO','learner','beginner','2025-04-12 22:27:10','2025-04-12 22:32:14'),(3,'Thanh Tran','thanhtt','$2b$10$EHqOCwtPKjEiOmiO2J7GS.I6SvkTe1c4BAeqTc4wG1wCTR3dZUQCS','admin','elementary','2025-04-12 23:39:58','2025-04-16 22:11:58'),(4,'luan','123456','$2b$10$1Zv6buXyhX9lzMSre.1.k.FbueCByjFa5cRtHBBpct4Luer9eRsB.','learner','expert','2025-04-13 13:13:21','2025-04-19 23:14:47'),(5,'ultraman','ultr','$2b$10$/AHJnb6Nmi569pvr5/4k.eGu9P4dZHhKn7Ei/YEEvLnUSze1z3lv2','learner','beginner','2025-04-13 15:05:26','2025-04-13 15:05:26'),(6,'truong23','truong1','$2b$10$f8KJuqvSLI9qok/jMzdL8uF9mpRTRzVCO3eM91NKMX6PX9sN/zkaa','learner','intermediate','2025-04-20 17:06:37','2025-04-20 17:23:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vocabulary`
--

DROP TABLE IF EXISTS `vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(255) NOT NULL,
  `meaning` text NOT NULL,
  `level` enum('beginner','elementary','intermediate','advanced','expert') NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `example` text,
  `topicId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topicId` (`topicId`),
  CONSTRAINT `vocabulary_ibfk_1` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_10` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_100` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_101` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_102` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_103` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_104` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_105` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_106` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_107` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_108` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_109` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_11` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_110` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_111` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_112` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_113` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_114` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_115` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_116` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_117` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_118` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_119` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_12` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_120` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_121` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_122` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_123` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_124` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_125` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_126` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_127` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_128` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_129` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_13` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_130` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_131` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_132` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_133` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_134` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_135` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_136` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_137` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_138` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_139` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_14` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_140` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_141` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_142` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_143` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_144` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_145` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_146` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_147` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_148` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_149` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_15` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_150` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_151` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_152` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_153` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_154` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_155` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_156` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_157` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_158` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_159` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_16` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_160` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_161` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_162` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_163` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_164` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_165` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_166` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_167` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_168` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_169` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_17` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_170` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_171` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_172` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_173` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_174` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_175` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_176` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_177` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_178` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_179` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_18` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_180` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_181` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_182` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_183` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_184` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_185` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_186` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_187` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_188` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_189` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_19` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_190` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_191` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_192` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_193` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_194` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_195` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_196` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_197` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_198` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_199` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_2` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_20` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_200` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_201` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_202` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_203` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_204` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_205` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_206` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_207` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_208` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_209` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_21` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_210` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_211` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_212` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_213` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_214` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_215` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_216` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_217` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_218` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_219` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_22` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_220` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_221` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_222` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_223` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_224` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_225` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_226` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_227` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_228` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_229` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_23` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_230` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_231` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_232` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_233` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_234` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_235` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_236` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_237` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_238` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_239` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_24` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_240` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_241` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_242` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_243` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_244` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_245` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_246` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_247` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_248` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_249` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_25` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_250` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_251` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_252` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_253` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_254` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_255` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_256` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_257` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_258` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_259` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_26` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_260` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_261` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_262` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_263` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_264` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_265` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_266` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_267` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_268` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_269` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_27` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_270` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_271` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_272` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_273` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_274` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_275` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_276` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_277` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_278` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_279` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_28` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_280` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_281` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_282` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_283` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_284` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_285` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_286` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_287` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_288` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_289` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_29` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_290` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_291` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_292` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_293` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_294` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_295` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_296` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_297` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_298` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_3` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_30` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_31` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_32` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_33` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_34` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_35` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_36` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_37` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_38` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_39` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_4` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_40` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_41` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_42` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_43` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_44` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_45` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_46` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_47` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_48` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_49` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_5` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_50` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_51` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_52` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_53` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_54` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_55` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_56` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_57` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_58` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_59` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_6` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_60` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_61` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_62` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_63` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_64` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_65` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_66` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_67` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_68` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_69` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_7` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_70` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_71` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_72` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_73` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_74` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_75` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_76` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_77` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_78` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_79` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_8` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_80` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_81` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_82` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_83` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_84` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_85` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_86` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_87` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_88` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_89` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_9` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_90` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_91` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_92` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_93` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_94` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_95` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_96` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_97` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_98` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_ibfk_99` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `vocabulary_topicId_foreign_idx` FOREIGN KEY (`topicId`) REFERENCES `topics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vocabulary`
--

LOCK TABLES `vocabulary` WRITE;
/*!40000 ALTER TABLE `vocabulary` DISABLE KEYS */;
INSERT INTO `vocabulary` VALUES (13,'hello','xin chào','beginner','2025-04-12 19:05:34','2025-04-16 18:22:07','Hello, how are you today?',3),(14,'goodbye','tạm biệt','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','Goodbye! See you next time.',3),(15,'thank you','cảm ơn','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','Thank you for your help.',3),(16,'please','làm ơn','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','\"Please help me,\" he said.',3),(17,'yes','có','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','Yes, I would love to join the party.',3),(18,'no','không','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','He said no without hesitation.',3),(19,'sorry','xin lỗi','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','\"Sorry, I didn’t mean to bump into you.\"',3),(20,'name','tên','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','What is your name?',3),(21,'age','tuổi','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','He asked me about my age.',3),(22,'time','thời gian','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','Do you have time for a quick chat?',3),(23,'day','ngày','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'day\' means \'ngày\' in Vietnamese.',7),(24,'night','đêm','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'night\' means \'đêm\' in Vietnamese.',7),(25,'food','thức ăn','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'food\' means \'thức ăn\' in Vietnamese.',7),(26,'water','nước','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'water\' means \'nước\' in Vietnamese.',7),(27,'home','nhà','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'home\' means \'nhà\' in Vietnamese.',7),(28,'school','trường học','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'school\' means \'trường học\' in Vietnamese.',7),(29,'work','làm việc','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'work\' means \'làm việc\' in Vietnamese.',7),(30,'family','gia đình','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'family\' means \'gia đình\' in Vietnamese.',7),(31,'friend','bạn bè','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'friend\' means \'bạn bè\' in Vietnamese.',7),(32,'help','giúp đỡ','beginner','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'help\' means \'giúp đỡ\' in Vietnamese.',7),(33,'morning','buổi sáng','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'morning\' means \'buổi sáng\' in Vietnamese.',1),(34,'afternoon','buổi chiều','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'afternoon\' means \'buổi chiều\' in Vietnamese.',1),(35,'evening','buổi tối','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'evening\' means \'buổi tối\' in Vietnamese.',1),(36,'week','tuần','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'week\' means \'tuần\' in Vietnamese.',1),(37,'month','tháng','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'month\' means \'tháng\' in Vietnamese.',1),(38,'year','năm','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'year\' means \'năm\' in Vietnamese.',1),(39,'weather','thời tiết','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'weather\' means \'thời tiết\' in Vietnamese.',1),(40,'season','mùa','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'season\' means \'mùa\' in Vietnamese.',1),(41,'color','màu sắc','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'color\' means \'màu sắc\' in Vietnamese.',1),(42,'number','số','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'number\' means \'số\' in Vietnamese.',1),(43,'animal','động vật','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'animal\' means \'động vật\' in Vietnamese.',2),(44,'plant','cây cối','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'plant\' means \'cây cối\' in Vietnamese.',2),(45,'city','thành phố','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'city\' means \'thành phố\' in Vietnamese.',2),(46,'country','đất nước','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'country\' means \'đất nước\' in Vietnamese.',2),(47,'language','ngôn ngữ','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'language\' means \'ngôn ngữ\' in Vietnamese.',2),(48,'music','âm nhạc','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'music\' means \'âm nhạc\' in Vietnamese.',2),(49,'sport','thể thao','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'sport\' means \'thể thao\' in Vietnamese.',2),(50,'movie','phim','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'movie\' means \'phim\' in Vietnamese.',2),(51,'book','sách','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'book\' means \'sách\' in Vietnamese.',2),(52,'computer','máy tính','elementary','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'computer\' means \'máy tính\' in Vietnamese.',2),(53,'communication','giao tiếp','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'communication\' means \'giao tiếp\' in Vietnamese.',4),(54,'education','giáo dục','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'education\' means \'giáo dục\' in Vietnamese.',4),(55,'environment','môi trường','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'environment\' means \'môi trường\' in Vietnamese.',4),(56,'technology','công nghệ','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'technology\' means \'công nghệ\' in Vietnamese.',4),(57,'business','kinh doanh','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'business\' means \'kinh doanh\' in Vietnamese.',4),(58,'economy','kinh tế','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'economy\' means \'kinh tế\' in Vietnamese.',4),(59,'politics','chính trị','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'politics\' means \'chính trị\' in Vietnamese.',4),(60,'society','xã hội','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'society\' means \'xã hội\' in Vietnamese.',4),(61,'culture','văn hóa','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'culture\' means \'văn hóa\' in Vietnamese.',4),(62,'tradition','truyền thống','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'tradition\' means \'truyền thống\' in Vietnamese.',4),(63,'history','lịch sử','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'history\' means \'lịch sử\' in Vietnamese.',9),(64,'science','khoa học','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'science\' means \'khoa học\' in Vietnamese.',9),(65,'research','nghiên cứu','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'research\' means \'nghiên cứu\' in Vietnamese.',9),(66,'development','phát triển','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'development\' means \'phát triển\' in Vietnamese.',9),(67,'management','quản lý','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'management\' means \'quản lý\' in Vietnamese.',9),(68,'organization','tổ chức','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'organization\' means \'tổ chức\' in Vietnamese.',9),(69,'relationship','mối quan hệ','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'relationship\' means \'mối quan hệ\' in Vietnamese.',9),(70,'experience','kinh nghiệm','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'experience\' means \'kinh nghiệm\' in Vietnamese.',9),(71,'knowledge','kiến thức','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'knowledge\' means \'kiến thức\' in Vietnamese.',9),(72,'opportunity','cơ hội','intermediate','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'opportunity\' means \'cơ hội\' in Vietnamese.',9),(73,'accomplishment','thành tựu','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'accomplishment\' means \'thành tựu\' in Vietnamese.',5),(74,'achievement','thành tích','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'achievement\' means \'thành tích\' in Vietnamese.',5),(75,'ambition','tham vọng','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'ambition\' means \'tham vọng\' in Vietnamese.',5),(76,'aspiration','khát vọng','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'aspiration\' means \'khát vọng\' in Vietnamese.',5),(77,'capability','năng lực','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'capability\' means \'năng lực\' in Vietnamese.',5),(78,'competence','năng lực','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'competence\' means \'năng lực\' in Vietnamese.',5),(79,'determination','quyết tâm','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'determination\' means \'quyết tâm\' in Vietnamese.',5),(80,'diligence','siêng năng','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'diligence\' means \'siêng năng\' in Vietnamese.',5),(81,'excellence','xuất sắc','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'excellence\' means \'xuất sắc\' in Vietnamese.',5),(82,'expertise','chuyên môn','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'expertise\' means \'chuyên môn\' in Vietnamese.',5),(83,'innovation','đổi mới','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'innovation\' means \'đổi mới\' in Vietnamese.',10),(84,'leadership','khả năng lãnh đạo','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'leadership\' means \'khả năng lãnh đạo\' in Vietnamese.',10),(85,'perseverance','kiên trì','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'perseverance\' means \'kiên trì\' in Vietnamese.',10),(86,'potential','tiềm năng','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'potential\' means \'tiềm năng\' in Vietnamese.',10),(87,'proficiency','thành thạo','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'proficiency\' means \'thành thạo\' in Vietnamese.',10),(88,'qualification','trình độ','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'qualification\' means \'trình độ\' in Vietnamese.',10),(89,'reliability','độ tin cậy','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'reliability\' means \'độ tin cậy\' in Vietnamese.',10),(90,'responsibility','trách nhiệm','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'responsibility\' means \'trách nhiệm\' in Vietnamese.',10),(91,'sophistication','sự tinh vi','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'sophistication\' means \'sự tinh vi\' in Vietnamese.',10),(92,'versatility','tính linh hoạt','advanced','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'versatility\' means \'tính linh hoạt\' in Vietnamese.',10),(93,'abstemious','tiết chế','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'abstemious\' means \'tiết chế\' in Vietnamese.',6),(94,'benevolent','nhân từ','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'benevolent\' means \'nhân từ\' in Vietnamese.',6),(95,'circumspect','thận trọng','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'circumspect\' means \'thận trọng\' in Vietnamese.',6),(96,'discerning','sáng suốt','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'discerning\' means \'sáng suốt\' in Vietnamese.',6),(97,'equanimity','bình tĩnh','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'equanimity\' means \'bình tĩnh\' in Vietnamese.',6),(98,'fastidious','kỹ tính','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'fastidious\' means \'kỹ tính\' in Vietnamese.',6),(99,'gregarious','hòa đồng','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'gregarious\' means \'hòa đồng\' in Vietnamese.',6),(100,'humility','khiêm tốn','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'humility\' means \'khiêm tốn\' in Vietnamese.',6),(101,'indomitable','bất khuất','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'indomitable\' means \'bất khuất\' in Vietnamese.',6),(102,'judicious','sáng suốt','expert','2025-04-12 19:05:34','2025-04-12 19:05:34','I learned that the word \'judicious\' means \'sáng suốt\' in Vietnamese.',6),(103,'kaleidoscopic','đa dạng','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'kaleidoscopic\' means \'đa dạng\' in Vietnamese.',12),(104,'luminous','sáng chói','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'luminous\' means \'sáng chói\' in Vietnamese.',12),(105,'magnanimous','rộng lượng','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'magnanimous\' means \'rộng lượng\' in Vietnamese.',12),(106,'noble','cao quý','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'noble\' means \'cao quý\' in Vietnamese.',12),(107,'obligation','nghĩa vụ','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'obligation\' means \'nghĩa vụ\' in Vietnamese.',12),(108,'persevere','kiên trì','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'persevere\' means \'kiên trì\' in Vietnamese.',12),(109,'quintessential','tinh túy','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'quintessential\' means \'tinh túy\' in Vietnamese.',12),(110,'resilience','khả năng phục hồi','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'resilience\' means \'khả năng phục hồi\' in Vietnamese.',12),(111,'sagacious','thông thái','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'sagacious\' means \'thông thái\' in Vietnamese.',12),(112,'tenacity','sự bền bỉ','expert','2025-04-12 19:05:34','2025-04-17 21:15:50','I learned that the word \'tenacity\' means \'sự bền bỉ\' in Vietnamese.',12);
/*!40000 ALTER TABLE `vocabulary` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-20 20:18:53
