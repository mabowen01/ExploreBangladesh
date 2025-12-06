-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (x86_64)
--
-- Host: localhost    Database: explore_bd
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `content` text,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,3,3,'food','ajshfhafncannac','2025-06-01 15:30:39'),(2,3,3,'food','wow nice food','2025-06-01 15:41:45'),(3,3,5,'food','hhhhh','2025-06-01 18:04:06'),(4,3,7,'movie','mmmm','2025-06-02 16:39:59'),(5,3,6,'food','mmmm','2025-06-02 17:11:54'),(6,3,7,'movie','mmmmm','2025-06-02 17:31:10'),(7,3,7,'movie','mmm','2025-06-02 17:34:14'),(8,3,14,'food','dddd','2025-06-02 19:22:18'),(9,1,15,'food','gijemsmrw','2025-06-03 01:31:58'),(10,3,13,'food','hhhhh','2025-06-03 18:33:28'),(11,3,3,'scenery','nnnnn','2025-06-03 18:52:22'),(12,4,13,'food','发发发f','2025-06-03 20:12:53'),(13,1,15,'food','vvv','2025-06-03 22:28:07'),(14,3,17,'food','cxzX  z','2025-06-04 11:09:39'),(15,3,23,'food','nice','2025-06-05 10:14:19');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (20,'Biriyani (বিরিয়ানি)','Fragrant rice layered with marinated meat and spices. Dhaka Kacchi Biryani is especially iconic.','uploads/Lamb Biryani - Coolinarco_com.jpeg'),(21,'Hilsa Fish Curry (ইলিশ মাছের তরকারি)','孟加拉的国鱼，用芥末或传统香料烹制。节日必吃的传统美食。','uploads/Homemade shorshe ilish (hilsa fish with mustard curry) served with white rice.jpeg'),(22,'泡饭配炸 Hilsa（Panta Ilish）| পান্তা ইলিশhhh','发酵米饭配炸伊利什鱼、洋葱和青椒。孟加拉新年时常吃的传统菜。','uploads/Recipes Archives.jpeg');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_like` (`user_id`,`item_id`,`item_type`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (6,1,7,'food'),(13,1,10,'movie'),(12,1,13,'food'),(8,1,15,'food'),(1,3,3,'food'),(10,3,3,'scenery'),(2,3,5,'food'),(5,3,6,'food'),(4,3,7,'movie'),(9,3,13,'food'),(7,3,14,'food'),(14,3,17,'food'),(17,3,23,'food'),(11,4,13,'food');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (15,'《汽车车夫》（Aynabaji）| আয়নাবাজি','犯罪心理题材，男主角以身份变换生活。大受欢迎，被称为新时代商业电影代表。','uploads/Screenshot 2025-06-04 at 5.02.12 PM.png'),(16,'《Hawa》（风）| হাওয়া','近年来极具人气的悬疑电影，背景为海上捕鱼船。情节紧凑，气氛压抑而引人入胜。','uploads/Hawa_film_poster.jpg'),(17,'《破碎之心》（Monpura）| মনপুরা','爱情与悲剧的完美结合，背景设在一个河岛上。影片的音乐也极受欢迎。','uploads/Monpura_Poster.jpg');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music`
--

DROP TABLE IF EXISTS `music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `music` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music`
--

LOCK TABLES `music` WRITE;
/*!40000 ALTER TABLE `music` DISABLE KEYS */;
INSERT INTO `music` VALUES (18,'民谣音乐（Folk Music）民间音乐','	传承乡土文化与生活智慧，常用传统乐器演奏。','uploads/The Baul (Bengali_ বাউল).jpeg'),(19,'古典音乐（Classical Music）古典音乐','深受印度次大陆古典传统影响，有Dhrupad和Khayal等形式。','uploads/James (Bangladesh).jpeg'),(20,'纳兹鲁尔·伊斯兰（Kazi Nazrul Islam）简介','他被称为“反抗诗人”，因其作品鼓励人民反抗压迫、不公与殖民统治。\r\n','uploads/Kazi Nazrul Islam Birthday Poster - Suronjit Tanu.jpeg');
/*!40000 ALTER TABLE `music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenery`
--

DROP TABLE IF EXISTS `scenery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scenery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenery`
--

LOCK TABLES `scenery` WRITE;
/*!40000 ALTER TABLE `scenery` DISABLE KEYS */;
INSERT INTO `scenery` VALUES (6,'孙达尔本森林（Sundarbans） | সুন্দরবন','世界上最大的红树林森林，孟加拉虎的家园。联合国教科文组织世界遗产之一。','uploads/_.jpeg'),(7,'科克斯巴扎尔海滩（Cox’s Bazar Beach） | কক্সবাজার সমুদ্র সৈকত','世界上最长的天然海滩之一。风景优美，是最受欢迎的海滨度假地。','uploads/Landpage Bangladesh.jpeg'),(8,'巴勒布布扎清真寺（Sixty Dome Mosque） | ষাট গম্বুজ মসজিদ','建于15世纪的伊斯兰建筑奇迹，位于巴格尔哈德。也是世界文化遗产之一。','uploads/Sixty Dome Mosque_ UNESCO World Heritage Site, Khulna, Bangladesh.jpeg');
/*!40000 ALTER TABLE `scenery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sport`
--

DROP TABLE IF EXISTS `sport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sport` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport`
--

LOCK TABLES `sport` WRITE;
/*!40000 ALTER TABLE `sport` DISABLE KEYS */;
INSERT INTO `sport` VALUES (7,'板球（Cricket）| ক্রিকেট','孟加拉国最受欢迎的运动，全国各地都有板球迷。国家队在国际赛事中表现亮眼。','uploads/bd cricket in 2022 _ Cricket wallpapers, Bangla comics, Bangladesh cricket team.jpeg'),(8,'卡巴迪（Kabaddi）| কাবাডি','孟加拉国的国家运动，结合力量与技巧的传统项目。常见于乡村地区','uploads/Kabaddi game.jpeg'),(9,'足球（Football）| ফুটবল','虽然板球更流行，但足球在乡村和青少年中仍然很受欢迎。拥有本地联赛与大量球迷。','uploads/Bangladesh women outclass India in Saff.jpeg');
/*!40000 ALTER TABLE `sport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Admin','admin@bd.com','admin123','admin'),(3,'mahadi','zannatulferdous8504@gmail.com','123','user'),(4,'马博文·','john@exampl.com','123','user');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-08 18:50:23
