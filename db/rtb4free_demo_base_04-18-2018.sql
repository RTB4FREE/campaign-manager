-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: rtb4free
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `data` longblob,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner_videos`
--

DROP TABLE IF EXISTS `banner_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` int(11) DEFAULT NULL,
  `interval_start` datetime DEFAULT NULL,
  `interval_end` datetime DEFAULT NULL,
  `total_basket_value` decimal(15,6) DEFAULT NULL,
  `total_budget` decimal(15,6) DEFAULT NULL,
  `vast_video_width` int(11) DEFAULT NULL,
  `vast_video_height` int(11) DEFAULT NULL,
  `bid_ecpm` decimal(15,6) DEFAULT NULL,
  `vast_video_linerarity` int(11) DEFAULT NULL,
  `vast_video_duration` int(11) DEFAULT NULL,
  `vast_video_type` mediumtext COLLATE utf8mb4_polish_ci,
  `vast_video_outgoing_file` longtext COLLATE utf8mb4_polish_ci,
  `bids` int(11) DEFAULT NULL,
  `clicks` int(11) DEFAULT NULL,
  `pixels` int(11) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `total_cost` decimal(15,6) DEFAULT '0.000000',
  `daily_cost` decimal(15,6) DEFAULT NULL,
  `daily_budget` decimal(15,6) DEFAULT NULL,
  `frequency_spec` mediumtext COLLATE utf8mb4_polish_ci,
  `frequency_expire` int(11) DEFAULT NULL,
  `frequency_count` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `hourly_budget` decimal(15,6) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `hourly_cost` decimal(15,6) DEFAULT NULL,
  `bitrate` int(11) DEFAULT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `deals` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `width_range` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `height_range` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `width_height_list` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner_videos`
--

LOCK TABLES `banner_videos` WRITE;
/*!40000 ALTER TABLE `banner_videos` DISABLE KEYS */;
INSERT INTO `banner_videos` VALUES (5,2,'2018-01-01 00:00:00','2020-01-01 00:00:00',NULL,NULL,400,200,1.000000,1,50,'5','<VAST xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" version=\"2.0\" xsi:noNamespaceSchemaLocation=\"vast.xsd\">\r\n<Ad id=\"270\" >\r\n<InLine>\r\n<AdSystem version=\"2.0\">ONION</AdSystem>\r\n<AdTitle>In-Stream Video</AdTitle>\r\n<Description>Cottonelle Video Skin 7/15</Description>\r\n<Impression><![CDATA[https://ad.doubleclick.net/ad/N3186.3804.ONIONINC/B8043482.3;sz=1x1;pc=[TPAS_ID];ord=%%CACHEBUSTER%%?]]></Impression> \r\n<Impression><![CDATA[http://influxer.onion.com/influx.gif?site=onionads&event=impression&content_id=270&path=/vast/270.xml]]></Impression> \r\n<Impression><![CDATA[http://ra.onion.com/video-ad.gif?video_ad=270&event=impression]]></Impression>\r\n<Impression><![CDATA[{pixel_url}/exchange={exchange}/ad_id={ad_id}/creative_id={creative_id}/price=${AUCTION_PRICE}/lat={lat}/lon={lon}/bid_id={bid_id}]]></Impression> \r\n<Creatives>\r\n<Creative sequence=\"1\" AdID=\"270\">\r\n<Linear>\r\n<Duration>00:01:05</Duration>\r\n<TrackingEvents>\r\n<Tracking event=\"start\"><![CDATA[ http://influxer.onion.com/influx.gif?site=onionads&event=start&content_id=270&path=/vast/270.xml]]></Tracking>\r\n<Tracking event=\"start\"><![CDATA[ http://ra.onion.com/video-ad.gif?video_ad=270&event=start]]></Tracking>\r\n<Tracking event=\"firstQuartile\"><![CDATA[ http://influxer.onion.com/influx.gif?site=onionads&event=firstQuartile&content_id=270&path=/vast/270.xml ]]></Tracking>\r\n<Tracking event=\"firstQuartile\"><![CDATA[ http://ra.onion.com/video-ad.gif?video_ad=270&event=firstQuartile ]]></Tracking>\r\n<Tracking event=\"midpoint\"><![CDATA[ http://influxer.onion.com/influx.gif?site=onionads&event=midpoint&content_id=270&path=/vast/270.xml ]]></Tracking>\r\n<Tracking event=\"midpoint\"><![CDATA[ http://ra.onion.com/video-ad.gif?video_ad=270&event=midpoint ]]></Tracking>\r\n<Tracking event=\"thirdQuartile\"><![CDATA[ http://influxer.onion.com/influx.gif?site=onionads&event=thirdQuartile&content_id=270&path=/vast/270.xml ]]></Tracking>\r\n<Tracking event=\"thirdQuartile\"><![CDATA[ http://ra.onion.com/video-ad.gif?video_ad=270&event=thirdQuartile ]]></Tracking>\r\n<Tracking event=\"complete\"><![CDATA[ http://influxer.onion.com/influx.gif?site=onionads&event=complete&content_id=270&path=/vast/270.xml ]]></Tracking>\r\n<Tracking event=\"complete\"><![CDATA[ http://ra.onion.com/video-ad.gif?video_ad=270&event=complete ]]></Tracking>\r\n</TrackingEvents>\r\n<VideoClicks>\r\n<ClickThrough><![CDATA[https://ad.doubleclick.net/clk;281053485;107792520;e;pc=[TPAS_ID]]]></ClickThrough>\r\n</VideoClicks>\r\n<MediaFiles>\r\n<MediaFile delivery=\"progressive\" type=\"video/webm\" bitrate=\"340\" width=\"640\" height=\"\">\r\n<![CDATA[http://v.theonion.com/onionwebtech/videoads/525/sd.webm]]>\r\n</MediaFile>\r\n<MediaFile delivery=\"progressive\" type=\"video/mp4\" bitrate=\"474\" width=\"640\" height=\"\">\r\n<![CDATA[http://v.theonion.com/onionwebtech/videoads/525/sd.mp4]]>\r\n</MediaFile>\r\n<MediaFile delivery=\"progressive\" type=\"application/x-mpegurl\" bitrate=\"None\" width=\"None\" height=\"\">\r\n<![CDATA[http://v.theonion.com/onionwebtech/videoads/525/hls_playlist.m3u8]]>\r\n</MediaFile>\r\n</MediaFiles>\r\n</Linear>\r\n</Creative>\r\n</Creatives>\r\n</InLine>\r\n\r\n\r\n</Ad>\r\n</VAST>',NULL,NULL,NULL,NULL,0.000000,NULL,NULL,'',NULL,NULL,'2017-05-01 20:55:25','2018-04-18 21:29:41',NULL,'Demo Video ',NULL,NULL,2000,'video/mp4','',NULL,NULL,NULL);
/*!40000 ALTER TABLE `banner_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner_videos_rtb_standards`
--

DROP TABLE IF EXISTS `banner_videos_rtb_standards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_videos_rtb_standards` (
  `banner_video_id` int(11) DEFAULT NULL,
  `rtb_standard_id` int(11) DEFAULT NULL,
  KEY `index_banner_videos_rtb_standards_on_banner_video_id` (`banner_video_id`),
  KEY `index_banner_videos_rtb_standards_on_rtb_standard_id` (`rtb_standard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner_videos_rtb_standards`
--

LOCK TABLES `banner_videos_rtb_standards` WRITE;
/*!40000 ALTER TABLE `banner_videos_rtb_standards` DISABLE KEYS */;
/*!40000 ALTER TABLE `banner_videos_rtb_standards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` int(11) DEFAULT NULL,
  `interval_start` datetime NOT NULL,
  `interval_end` datetime DEFAULT NULL,
  `total_basket_value` decimal(15,6) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `bid_ecpm` decimal(15,6) DEFAULT NULL,
  `total_cost` decimal(15,6) DEFAULT NULL,
  `contenttype` varchar(1024) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `iurl` varchar(1024) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `htmltemplate` longtext COLLATE utf8mb4_polish_ci,
  `bids` int(11) DEFAULT NULL,
  `clicks` int(11) DEFAULT NULL,
  `pixels` int(11) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `daily_budget` decimal(15,6) DEFAULT NULL,
  `hourly_budget` decimal(15,6) DEFAULT NULL,
  `daily_cost` decimal(15,6) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `frequency_spec` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `frequency_expire` int(11) DEFAULT NULL,
  `frequency_count` int(11) DEFAULT NULL,
  `hourly_cost` decimal(15,6) DEFAULT NULL,
  `deals` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `width_range` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `height_range` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `width_height_list` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners`
--

LOCK TABLES `banners` WRITE;
/*!40000 ALTER TABLE `banners` DISABLE KEYS */;
INSERT INTO `banners` VALUES (6,2,'2018-01-01 00:00:00','2020-01-01 00:00:00',NULL,320,50,1.000000,NULL,'html','$EXTERNAL/images/320x50.jpg?adid={ad_id}&bidid={bid_id}','<img src=\"{pixel_url}/exchange={exchange}&ad_id={ad_id}&creative_id={creative_id}&price=${AUCTION_PRICE}&bid_id={bid_id}&site_domain={site_domain}\" height=\"1\" width=\"1\" style=\"display:none;\"/>\r\n<a href=\"{clickurl}{redirect_url}/exchange={exchange}&ad_id={ad_id}&creative_id={creative_id}&bid_id={bid_id}&site_domain={site_domain}?url=http://rtb4free.com/contact.html\" target=\"_blank\">\r\n<img src=\"$EXTERNAL/images/320x50.jpg\" width=\"300\" height=\"250\" />\r\n</a>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-04-08 00:13:40','2018-04-18 20:40:46','Sample Banner Ad','',NULL,NULL,NULL,'',NULL,NULL,NULL);
/*!40000 ALTER TABLE `banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banners_rtb_standards`
--

DROP TABLE IF EXISTS `banners_rtb_standards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banners_rtb_standards` (
  `banner_id` int(11) DEFAULT NULL,
  `rtb_standard_id` int(11) DEFAULT NULL,
  KEY `index_banners_rtb_standards_on_banner_id` (`banner_id`),
  KEY `index_banners_rtb_standards_on_rtb_standard_id` (`rtb_standard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banners_rtb_standards`
--

LOCK TABLES `banners_rtb_standards` WRITE;
/*!40000 ALTER TABLE `banners_rtb_standards` DISABLE KEYS */;
/*!40000 ALTER TABLE `banners_rtb_standards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activate_time` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `cost` decimal(15,6) DEFAULT NULL,
  `ad_domain` varchar(1024) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `clicks` int(11) DEFAULT NULL,
  `pixels` int(11) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `bids` int(11) DEFAULT NULL,
  `name` varchar(1024) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `status` varchar(1024) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `conversion_type` varchar(1024) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `budget_limit_daily` decimal(15,6) DEFAULT NULL,
  `budget_limit_hourly` decimal(15,6) DEFAULT NULL,
  `total_budget` decimal(15,6) DEFAULT NULL,
  `bid` decimal(15,6) DEFAULT NULL,
  `shard` mediumtext COLLATE utf8mb4_polish_ci,
  `forensiq` mediumtext COLLATE utf8mb4_polish_ci,
  `daily_cost` decimal(15,6) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `hourly_cost` decimal(15,6) DEFAULT NULL,
  `exchanges` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `regions` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES (2,'2018-01-01 00:00:00','2020-01-01 00:00:00',NULL,'rtb4free.com',NULL,NULL,NULL,NULL,'Demo Campaign','runnable',NULL,NULL,NULL,100.000000,NULL,'','no',NULL,'2018-04-18 21:29:41',NULL,NULL,NULL,'nexage','US',1);
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns_rtb_standards`
--

DROP TABLE IF EXISTS `campaigns_rtb_standards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaigns_rtb_standards` (
  `campaign_id` int(11) DEFAULT NULL,
  `rtb_standard_id` int(11) DEFAULT NULL,
  KEY `index_campaigns_rtb_standards_on_campaign_id` (`campaign_id`),
  KEY `index_campaigns_rtb_standards_on_rtb_standard_id` (`rtb_standard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns_rtb_standards`
--

LOCK TABLES `campaigns_rtb_standards` WRITE;
/*!40000 ALTER TABLE `campaigns_rtb_standards` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaigns_rtb_standards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) DEFAULT NULL,
  `description` varchar(2048) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_documents`
--

DROP TABLE IF EXISTS `categories_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_documents` (
  `document_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  KEY `index_categories_documents_on_document_id` (`document_id`),
  KEY `index_categories_documents_on_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_documents`
--

LOCK TABLES `categories_documents` WRITE;
/*!40000 ALTER TABLE `categories_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` varchar(255) DEFAULT NULL,
  `common_name` varchar(255) DEFAULT NULL,
  `formal_name` varchar(255) DEFAULT NULL,
  `country_type` varchar(255) DEFAULT NULL,
  `sub_type` varchar(255) DEFAULT NULL,
  `sovereignty` varchar(255) DEFAULT NULL,
  `capital` varchar(255) DEFAULT NULL,
  `iso_4217_currency_code` varchar(255) DEFAULT NULL,
  `iso_4217_currency_name` varchar(255) DEFAULT NULL,
  `itu-t_telephone_code` varchar(255) DEFAULT NULL,
  `iso_3166-1_2_letter_code` varchar(255) DEFAULT NULL,
  `iso_3166-1_3_letter_code` varchar(255) DEFAULT NULL,
  `iso_3166-1_number` varchar(255) DEFAULT NULL,
  `iana_country_code_tld` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (843,'1','Afghanistan','Islamic State of Afghanistan','Independent State',NULL,NULL,'Kabul','AFN','Afghani','93','AF','AFG','4','.af'),(844,'2','Albania','Republic of Albania','Independent State',NULL,NULL,'Tirana','ALL','Lek','355','AL','ALB','8','.al'),(845,'3','Algeria','People\'s Democratic Republic of Algeria','Independent State',NULL,NULL,'Algiers','DZD','Dinar','213','DZ','DZA','12','.dz'),(846,'4','Andorra','Principality of Andorra','Independent State',NULL,NULL,'Andorra la Vella','EUR','Euro','376','AD','AND','20','.ad'),(847,'5','Angola','Republic of Angola','Independent State',NULL,NULL,'Luanda','AOA','Kwanza','244','AO','AGO','24','.ao'),(848,'6','Antigua and Barbuda',NULL,'Independent State',NULL,NULL,'Saint John\'s','XCD','Dollar','-267','AG','ATG','28','.ag'),(849,'7','Argentina','Argentine Republic','Independent State',NULL,NULL,'Buenos Aires','ARS','Peso','54','AR','ARG','32','.ar'),(850,'8','Armenia','Republic of Armenia','Independent State',NULL,NULL,'Yerevan','AMD','Dram','374','AM','ARM','51','.am'),(851,'9','Australia','Commonwealth of Australia','Independent State',NULL,NULL,'Canberra','AUD','Dollar','61','AU','AUS','36','.au'),(852,'10','Austria','Republic of Austria','Independent State',NULL,NULL,'Vienna','EUR','Euro','43','AT','AUT','40','.at'),(853,'11','Azerbaijan','Republic of Azerbaijan','Independent State',NULL,NULL,'Baku','AZN','Manat','994','AZ','AZE','31','.az'),(854,'12','Bahamas, The','Commonwealth of The Bahamas','Independent State',NULL,NULL,'Nassau','BSD','Dollar','-241','BS','BHS','44','.bs'),(855,'13','Bahrain','Kingdom of Bahrain','Independent State',NULL,NULL,'Manama','BHD','Dinar','973','BH','BHR','48','.bh'),(856,'14','Bangladesh','People\'s Republic of Bangladesh','Independent State',NULL,NULL,'Dhaka','BDT','Taka','880','BD','BGD','50','.bd'),(857,'15','Barbados',NULL,'Independent State',NULL,NULL,'Bridgetown','BBD','Dollar','-245','BB','BRB','52','.bb'),(858,'16','Belarus','Republic of Belarus','Independent State',NULL,NULL,'Minsk','BYR','Ruble','375','BY','BLR','112','.by'),(859,'17','Belgium','Kingdom of Belgium','Independent State',NULL,NULL,'Brussels','EUR','Euro','32','BE','BEL','56','.be'),(860,'18','Belize',NULL,'Independent State',NULL,NULL,'Belmopan','BZD','Dollar','501','BZ','BLZ','84','.bz'),(861,'19','Benin','Republic of Benin','Independent State',NULL,NULL,'Porto-Novo','XOF','Franc','229','BJ','BEN','204','.bj'),(862,'20','Bhutan','Kingdom of Bhutan','Independent State',NULL,NULL,'Thimphu','BTN','Ngultrum','975','BT','BTN','64','.bt'),(863,'21','Bolivia','Republic of Bolivia','Independent State',NULL,NULL,'La Paz (administrative/legislative) and Sucre (judical)','BOB','Boliviano','591','BO','BOL','68','.bo'),(864,'22','Bosnia and Herzegovina',NULL,'Independent State',NULL,NULL,'Sarajevo','BAM','Marka','387','BA','BIH','70','.ba'),(865,'23','Botswana','Republic of Botswana','Independent State',NULL,NULL,'Gaborone','BWP','Pula','267','BW','BWA','72','.bw'),(866,'24','Brazil','Federative Republic of Brazil','Independent State',NULL,NULL,'Brasilia','BRL','Real','55','BR','BRA','76','.br'),(867,'25','Brunei','Negara Brunei Darussalam','Independent State',NULL,NULL,'Bandar Seri Begawan','BND','Dollar','673','BN','BRN','96','.bn'),(868,'26','Bulgaria','Republic of Bulgaria','Independent State',NULL,NULL,'Sofia','BGN','Lev','359','BG','BGR','100','.bg'),(869,'27','Burkina Faso',NULL,'Independent State',NULL,NULL,'Ouagadougou','XOF','Franc','226','BF','BFA','854','.bf'),(870,'28','Burundi','Republic of Burundi','Independent State',NULL,NULL,'Bujumbura','BIF','Franc','257','BI','BDI','108','.bi'),(871,'29','Cambodia','Kingdom of Cambodia','Independent State',NULL,NULL,'Phnom Penh','KHR','Riels','855','KH','KHM','116','.kh'),(872,'30','Cameroon','Republic of Cameroon','Independent State',NULL,NULL,'Yaounde','XAF','Franc','237','CM','CMR','120','.cm'),(873,'31','Canada',NULL,'Independent State',NULL,NULL,'Ottawa','CAD','Dollar','1','CA','CAN','124','.ca'),(874,'32','Cape Verde','Republic of Cape Verde','Independent State',NULL,NULL,'Praia','CVE','Escudo','238','CV','CPV','132','.cv'),(875,'33','Central African Republic',NULL,'Independent State',NULL,NULL,'Bangui','XAF','Franc','236','CF','CAF','140','.cf'),(876,'34','Chad','Republic of Chad','Independent State',NULL,NULL,'N\'Djamena','XAF','Franc','235','TD','TCD','148','.td'),(877,'35','Chile','Republic of Chile','Independent State',NULL,NULL,'Santiago (administrative/judical) and Valparaiso (legislative)','CLP','Peso','56','CL','CHL','152','.cl'),(878,'36','China, People\'s Republic of','People\'s Republic of China','Independent State',NULL,NULL,'Beijing','CNY','Yuan Renminbi','86','CN','CHN','156','.cn'),(879,'37','Colombia','Republic of Colombia','Independent State',NULL,NULL,'Bogota','COP','Peso','57','CO','COL','170','.co'),(880,'38','Comoros','Union of Comoros','Independent State',NULL,NULL,'Moroni','KMF','Franc','269','KM','COM','174','.km'),(881,'39','Congo, (Congo Kinshasa)','Democratic Republic of the Congo','Independent State',NULL,NULL,'Kinshasa','CDF','Franc','243','CD','COD','180','.cd'),(882,'40','Congo, (Congo Brazzaville)','Republic of the Congo','Independent State',NULL,NULL,'Brazzaville','XAF','Franc','242','CG','COG','178','.cg'),(883,'41','Costa Rica','Republic of Costa Rica','Independent State',NULL,NULL,'San Jose','CRC','Colon','506','CR','CRI','188','.cr'),(884,'42','Cote d\'Ivoire (Ivory Coast)','Republic of Cote d\'Ivoire','Independent State',NULL,NULL,'Yamoussoukro','XOF','Franc','225','CI','CIV','384','.ci'),(885,'43','Croatia','Republic of Croatia','Independent State',NULL,NULL,'Zagreb','HRK','Kuna','385','HR','HRV','191','.hr'),(886,'44','Cuba','Republic of Cuba','Independent State',NULL,NULL,'Havana','CUP','Peso','53','CU','CUB','192','.cu'),(887,'45','Cyprus','Republic of Cyprus','Independent State',NULL,NULL,'Nicosia','CYP','Pound','357','CY','CYP','196','.cy'),(888,'46','Czech Republic',NULL,'Independent State',NULL,NULL,'Prague','CZK','Koruna','420','CZ','CZE','203','.cz'),(889,'47','Denmark','Kingdom of Denmark','Independent State',NULL,NULL,'Copenhagen','DKK','Krone','45','DK','DNK','208','.dk'),(890,'48','Djibouti','Republic of Djibouti','Independent State',NULL,NULL,'Djibouti','DJF','Franc','253','DJ','DJI','262','.dj'),(891,'49','Dominica','Commonwealth of Dominica','Independent State',NULL,NULL,'Roseau','XCD','Dollar','-766','DM','DMA','212','.dm'),(892,'50','Dominican Republic',NULL,'Independent State',NULL,NULL,'Santo Domingo','DOP','Peso','+1-809 and 1-829','DO','DOM','214','.do'),(893,'51','Ecuador','Republic of Ecuador','Independent State',NULL,NULL,'Quito','USD','Dollar','593','EC','ECU','218','.ec'),(894,'52','Egypt','Arab Republic of Egypt','Independent State',NULL,NULL,'Cairo','EGP','Pound','20','EG','EGY','818','.eg'),(895,'53','El Salvador','Republic of El Salvador','Independent State',NULL,NULL,'San Salvador','USD','Dollar','503','SV','SLV','222','.sv'),(896,'54','Equatorial Guinea','Republic of Equatorial Guinea','Independent State',NULL,NULL,'Malabo','XAF','Franc','240','GQ','GNQ','226','.gq'),(897,'55','Eritrea','State of Eritrea','Independent State',NULL,NULL,'Asmara','ERN','Nakfa','291','ER','ERI','232','.er'),(898,'56','Estonia','Republic of Estonia','Independent State',NULL,NULL,'Tallinn','EEK','Kroon','372','EE','EST','233','.ee'),(899,'57','Ethiopia','Federal Democratic Republic of Ethiopia','Independent State',NULL,NULL,'Addis Ababa','ETB','Birr','251','ET','ETH','231','.et'),(900,'58','Fiji','Republic of the Fiji Islands','Independent State',NULL,NULL,'Suva','FJD','Dollar','679','FJ','FJI','242','.fj'),(901,'59','Finland','Republic of Finland','Independent State',NULL,NULL,'Helsinki','EUR','Euro','358','FI','FIN','246','.fi'),(902,'60','France','French Republic','Independent State',NULL,NULL,'Paris','EUR','Euro','33','FR','FRA','250','.fr'),(903,'61','Gabon','Gabonese Republic','Independent State',NULL,NULL,'Libreville','XAF','Franc','241','GA','GAB','266','.ga'),(904,'62','Gambia, The','Republic of The Gambia','Independent State',NULL,NULL,'Banjul','GMD','Dalasi','220','GM','GMB','270','.gm'),(905,'63','Georgia','Republic of Georgia','Independent State',NULL,NULL,'Tbilisi','GEL','Lari','995','GE','GEO','268','.ge'),(906,'64','Germany','Federal Republic of Germany','Independent State',NULL,NULL,'Berlin','EUR','Euro','49','DE','DEU','276','.de'),(907,'65','Ghana','Republic of Ghana','Independent State',NULL,NULL,'Accra','GHC','Cedi','233','GH','GHA','288','.gh'),(908,'66','Greece','Hellenic Republic','Independent State',NULL,NULL,'Athens','EUR','Euro','30','GR','GRC','300','.gr'),(909,'67','Grenada',NULL,'Independent State',NULL,NULL,'Saint George\'s','XCD','Dollar','-472','GD','GRD','308','.gd'),(910,'68','Guatemala','Republic of Guatemala','Independent State',NULL,NULL,'Guatemala','GTQ','Quetzal','502','GT','GTM','320','.gt'),(911,'69','Guinea','Republic of Guinea','Independent State',NULL,NULL,'Conakry','GNF','Franc','224','GN','GIN','324','.gn'),(912,'70','Guinea-Bissau','Republic of Guinea-Bissau','Independent State',NULL,NULL,'Bissau','XOF','Franc','245','GW','GNB','624','.gw'),(913,'71','Guyana','Co-operative Republic of Guyana','Independent State',NULL,NULL,'Georgetown','GYD','Dollar','592','GY','GUY','328','.gy'),(914,'72','Haiti','Republic of Haiti','Independent State',NULL,NULL,'Port-au-Prince','HTG','Gourde','509','HT','HTI','332','.ht'),(915,'73','Honduras','Republic of Honduras','Independent State',NULL,NULL,'Tegucigalpa','HNL','Lempira','504','HN','HND','340','.hn'),(916,'74','Hungary','Republic of Hungary','Independent State',NULL,NULL,'Budapest','HUF','Forint','36','HU','HUN','348','.hu'),(917,'75','Iceland','Republic of Iceland','Independent State',NULL,NULL,'Reykjavik','ISK','Krona','354','IS','ISL','352','.is'),(918,'76','India','Republic of India','Independent State',NULL,NULL,'New Delhi','INR','Rupee','91','IN','IND','356','.in'),(919,'77','Indonesia','Republic of Indonesia','Independent State',NULL,NULL,'Jakarta','IDR','Rupiah','62','ID','IDN','360','.id'),(920,'78','Iran','Islamic Republic of Iran','Independent State',NULL,NULL,'Tehran','IRR','Rial','98','IR','IRN','364','.ir'),(921,'79','Iraq','Republic of Iraq','Independent State',NULL,NULL,'Baghdad','IQD','Dinar','964','IQ','IRQ','368','.iq'),(922,'80','Ireland',NULL,'Independent State',NULL,NULL,'Dublin','EUR','Euro','353','IE','IRL','372','.ie'),(923,'81','Israel','State of Israel','Independent State',NULL,NULL,'Jerusalem','ILS','Shekel','972','IL','ISR','376','.il'),(924,'82','Italy','Italian Republic','Independent State',NULL,NULL,'Rome','EUR','Euro','39','IT','ITA','380','.it'),(925,'83','Jamaica',NULL,'Independent State',NULL,NULL,'Kingston','JMD','Dollar','-875','JM','JAM','388','.jm'),(926,'84','Japan',NULL,'Independent State',NULL,NULL,'Tokyo','JPY','Yen','81','JP','JPN','392','.jp'),(927,'85','Jordan','Hashemite Kingdom of Jordan','Independent State',NULL,NULL,'Amman','JOD','Dinar','962','JO','JOR','400','.jo'),(928,'86','Kazakhstan','Republic of Kazakhstan','Independent State',NULL,NULL,'Astana','KZT','Tenge','7','KZ','KAZ','398','.kz'),(929,'87','Kenya','Republic of Kenya','Independent State',NULL,NULL,'Nairobi','KES','Shilling','254','KE','KEN','404','.ke'),(930,'88','Kiribati','Republic of Kiribati','Independent State',NULL,NULL,'Tarawa','AUD','Dollar','686','KI','KIR','296','.ki'),(931,'89','Korea, North','Democratic People\'s Republic of Korea','Independent State',NULL,NULL,'Pyongyang','KPW','Won','850','KP','PRK','408','.kp'),(932,'90','Korea, South','Republic of Korea','Independent State',NULL,NULL,'Seoul','KRW','Won','82','KR','KOR','410','.kr'),(933,'91','Kuwait','State of Kuwait','Independent State',NULL,NULL,'Kuwait','KWD','Dinar','965','KW','KWT','414','.kw'),(934,'92','Kyrgyzstan','Kyrgyz Republic','Independent State',NULL,NULL,'Bishkek','KGS','Som','996','KG','KGZ','417','.kg'),(935,'93','Laos','Lao People\'s Democratic Republic','Independent State',NULL,NULL,'Vientiane','LAK','Kip','856','LA','LAO','418','.la'),(936,'94','Latvia','Republic of Latvia','Independent State',NULL,NULL,'Riga','LVL','Lat','371','LV','LVA','428','.lv'),(937,'95','Lebanon','Lebanese Republic','Independent State',NULL,NULL,'Beirut','LBP','Pound','961','LB','LBN','422','.lb'),(938,'96','Lesotho','Kingdom of Lesotho','Independent State',NULL,NULL,'Maseru','LSL','Loti','266','LS','LSO','426','.ls'),(939,'97','Liberia','Republic of Liberia','Independent State',NULL,NULL,'Monrovia','LRD','Dollar','231','LR','LBR','430','.lr'),(940,'98','Libya','Great Socialist People\'s Libyan Arab Jamahiriya','Independent State',NULL,NULL,'Tripoli','LYD','Dinar','218','LY','LBY','434','.ly'),(941,'99','Liechtenstein','Principality of Liechtenstein','Independent State',NULL,NULL,'Vaduz','CHF','Franc','423','LI','LIE','438','.li'),(942,'100','Lithuania','Republic of Lithuania','Independent State',NULL,NULL,'Vilnius','LTL','Litas','370','LT','LTU','440','.lt'),(943,'101','Luxembourg','Grand Duchy of Luxembourg','Independent State',NULL,NULL,'Luxembourg','EUR','Euro','352','LU','LUX','442','.lu'),(944,'102','Macedonia','Republic of Macedonia','Independent State',NULL,NULL,'Skopje','MKD','Denar','389','MK','MKD','807','.mk'),(945,'103','Madagascar','Republic of Madagascar','Independent State',NULL,NULL,'Antananarivo','MGA','Ariary','261','MG','MDG','450','.mg'),(946,'104','Malawi','Republic of Malawi','Independent State',NULL,NULL,'Lilongwe','MWK','Kwacha','265','MW','MWI','454','.mw'),(947,'105','Malaysia',NULL,'Independent State',NULL,NULL,'Kuala Lumpur (legislative/judical) and Putrajaya (administrative)','MYR','Ringgit','60','MY','MYS','458','.my'),(948,'106','Maldives','Republic of Maldives','Independent State',NULL,NULL,'Male','MVR','Rufiyaa','960','MV','MDV','462','.mv'),(949,'107','Mali','Republic of Mali','Independent State',NULL,NULL,'Bamako','XOF','Franc','223','ML','MLI','466','.ml'),(950,'108','Malta','Republic of Malta','Independent State',NULL,NULL,'Valletta','MTL','Lira','356','MT','MLT','470','.mt'),(951,'109','Marshall Islands','Republic of the Marshall Islands','Independent State',NULL,NULL,'Majuro','USD','Dollar','692','MH','MHL','584','.mh'),(952,'110','Mauritania','Islamic Republic of Mauritania','Independent State',NULL,NULL,'Nouakchott','MRO','Ouguiya','222','MR','MRT','478','.mr'),(953,'111','Mauritius','Republic of Mauritius','Independent State',NULL,NULL,'Port Louis','MUR','Rupee','230','MU','MUS','480','.mu'),(954,'112','Mexico','United Mexican States','Independent State',NULL,NULL,'Mexico','MXN','Peso','52','MX','MEX','484','.mx'),(955,'113','Micronesia','Federated States of Micronesia','Independent State',NULL,NULL,'Palikir','USD','Dollar','691','FM','FSM','583','.fm'),(956,'114','Moldova','Republic of Moldova','Independent State',NULL,NULL,'Chisinau','MDL','Leu','373','MD','MDA','498','.md'),(957,'115','Monaco','Principality of Monaco','Independent State',NULL,NULL,'Monaco','EUR','Euro','377','MC','MCO','492','.mc'),(958,'116','Mongolia',NULL,'Independent State',NULL,NULL,'Ulaanbaatar','MNT','Tugrik','976','MN','MNG','496','.mn'),(959,'117','Montenegro','Republic of Montenegro','Independent State',NULL,NULL,'Podgorica','EUR','Euro','382','ME','MNE','499','.me and .yu'),(960,'118','Morocco','Kingdom of Morocco','Independent State',NULL,NULL,'Rabat','MAD','Dirham','212','MA','MAR','504','.ma'),(961,'119','Mozambique','Republic of Mozambique','Independent State',NULL,NULL,'Maputo','MZM','Meticail','258','MZ','MOZ','508','.mz'),(962,'120','Myanmar (Burma)','Union of Myanmar','Independent State',NULL,NULL,'Naypyidaw','MMK','Kyat','95','MM','MMR','104','.mm'),(963,'121','Namibia','Republic of Namibia','Independent State',NULL,NULL,'Windhoek','NAD','Dollar','264','NA','NAM','516','.na'),(964,'122','Nauru','Republic of Nauru','Independent State',NULL,NULL,'Yaren','AUD','Dollar','674','NR','NRU','520','.nr'),(965,'123','Nepal',NULL,'Independent State',NULL,NULL,'Kathmandu','NPR','Rupee','977','NP','NPL','524','.np'),(966,'124','Netherlands','Kingdom of the Netherlands','Independent State',NULL,NULL,'Amsterdam (administrative) and The Hague (legislative/judical)','EUR','Euro','31','NL','NLD','528','.nl'),(967,'125','New Zealand',NULL,'Independent State',NULL,NULL,'Wellington','NZD','Dollar','64','NZ','NZL','554','.nz'),(968,'126','Nicaragua','Republic of Nicaragua','Independent State',NULL,NULL,'Managua','NIO','Cordoba','505','NI','NIC','558','.ni'),(969,'127','Niger','Republic of Niger','Independent State',NULL,NULL,'Niamey','XOF','Franc','227','NE','NER','562','.ne'),(970,'128','Nigeria','Federal Republic of Nigeria','Independent State',NULL,NULL,'Abuja','NGN','Naira','234','NG','NGA','566','.ng'),(971,'129','Norway','Kingdom of Norway','Independent State',NULL,NULL,'Oslo','NOK','Krone','47','NO','NOR','578','.no'),(972,'130','Oman','Sultanate of Oman','Independent State',NULL,NULL,'Muscat','OMR','Rial','968','OM','OMN','512','.om'),(973,'131','Pakistan','Islamic Republic of Pakistan','Independent State',NULL,NULL,'Islamabad','PKR','Rupee','92','PK','PAK','586','.pk'),(974,'132','Palau','Republic of Palau','Independent State',NULL,NULL,'Melekeok','USD','Dollar','680','PW','PLW','585','.pw'),(975,'133','Panama','Republic of Panama','Independent State',NULL,NULL,'Panama','PAB','Balboa','507','PA','PAN','591','.pa'),(976,'134','Papua New Guinea','Independent State of Papua New Guinea','Independent State',NULL,NULL,'Port Moresby','PGK','Kina','675','PG','PNG','598','.pg'),(977,'135','Paraguay','Republic of Paraguay','Independent State',NULL,NULL,'Asuncion','PYG','Guarani','595','PY','PRY','600','.py'),(978,'136','Peru','Republic of Peru','Independent State',NULL,NULL,'Lima','PEN','Sol','51','PE','PER','604','.pe'),(979,'137','Philippines','Republic of the Philippines','Independent State',NULL,NULL,'Manila','PHP','Peso','63','PH','PHL','608','.ph'),(980,'138','Poland','Republic of Poland','Independent State',NULL,NULL,'Warsaw','PLN','Zloty','48','PL','POL','616','.pl'),(981,'139','Portugal','Portuguese Republic','Independent State',NULL,NULL,'Lisbon','EUR','Euro','351','PT','PRT','620','.pt'),(982,'140','Qatar','State of Qatar','Independent State',NULL,NULL,'Doha','QAR','Rial','974','QA','QAT','634','.qa'),(983,'141','Romania',NULL,'Independent State',NULL,NULL,'Bucharest','RON','Leu','40','RO','ROU','642','.ro'),(984,'142','Russia','Russian Federation','Independent State',NULL,NULL,'Moscow','RUB','Ruble','7','RU','RUS','643','.ru and .su'),(985,'143','Rwanda','Republic of Rwanda','Independent State',NULL,NULL,'Kigali','RWF','Franc','250','RW','RWA','646','.rw'),(986,'144','Saint Kitts and Nevis','Federation of Saint Kitts and Nevis','Independent State',NULL,NULL,'Basseterre','XCD','Dollar','-868','KN','KNA','659','.kn'),(987,'145','Saint Lucia',NULL,'Independent State',NULL,NULL,'Castries','XCD','Dollar','-757','LC','LCA','662','.lc'),(988,'146','Saint Vincent and the Grenadines',NULL,'Independent State',NULL,NULL,'Kingstown','XCD','Dollar','-783','VC','VCT','670','.vc'),(989,'147','Samoa','Independent State of Samoa','Independent State',NULL,NULL,'Apia','WST','Tala','685','WS','WSM','882','.ws'),(990,'148','San Marino','Republic of San Marino','Independent State',NULL,NULL,'San Marino','EUR','Euro','378','SM','SMR','674','.sm'),(991,'149','Sao Tome and Principe','Democratic Republic of Sao Tome and Principe','Independent State',NULL,NULL,'Sao Tome','STD','Dobra','239','ST','STP','678','.st'),(992,'150','Saudi Arabia','Kingdom of Saudi Arabia','Independent State',NULL,NULL,'Riyadh','SAR','Rial','966','SA','SAU','682','.sa'),(993,'151','Senegal','Republic of Senegal','Independent State',NULL,NULL,'Dakar','XOF','Franc','221','SN','SEN','686','.sn'),(994,'152','Serbia','Republic of Serbia','Independent State',NULL,NULL,'Belgrade','RSD','Dinar','381','RS','SRB','688','.rs and .yu'),(995,'153','Seychelles','Republic of Seychelles','Independent State',NULL,NULL,'Victoria','SCR','Rupee','248','SC','SYC','690','.sc'),(996,'154','Sierra Leone','Republic of Sierra Leone','Independent State',NULL,NULL,'Freetown','SLL','Leone','232','SL','SLE','694','.sl'),(997,'155','Singapore','Republic of Singapore','Independent State',NULL,NULL,'Singapore','SGD','Dollar','65','SG','SGP','702','.sg'),(998,'156','Slovakia','Slovak Republic','Independent State',NULL,NULL,'Bratislava','SKK','Koruna','421','SK','SVK','703','.sk'),(999,'157','Slovenia','Republic of Slovenia','Independent State',NULL,NULL,'Ljubljana','EUR','Euro','386','SI','SVN','705','.si'),(1000,'158','Solomon Islands',NULL,'Independent State',NULL,NULL,'Honiara','SBD','Dollar','677','SB','SLB','90','.sb'),(1001,'159','Somalia',NULL,'Independent State',NULL,NULL,'Mogadishu','SOS','Shilling','252','SO','SOM','706','.so'),(1002,'160','South Africa','Republic of South Africa','Independent State',NULL,NULL,'Pretoria (administrative), Cape Town (legislative), and Bloemfontein (judical)','ZAR','Rand','27','ZA','ZAF','710','.za'),(1003,'161','Spain','Kingdom of Spain','Independent State',NULL,NULL,'Madrid','EUR','Euro','34','ES','ESP','724','.es'),(1004,'162','Sri Lanka','Democratic Socialist Republic of Sri Lanka','Independent State',NULL,NULL,'Colombo (administrative/judical) and Sri Jayewardenepura Kotte (legislative)','LKR','Rupee','94','LK','LKA','144','.lk'),(1005,'163','Sudan','Republic of the Sudan','Independent State',NULL,NULL,'Khartoum','SDD','Dinar','249','SD','SDN','736','.sd'),(1006,'164','Suriname','Republic of Suriname','Independent State',NULL,NULL,'Paramaribo','SRD','Dollar','597','SR','SUR','740','.sr'),(1007,'165','Swaziland','Kingdom of Swaziland','Independent State',NULL,NULL,'Mbabane (administrative) and Lobamba (legislative)','SZL','Lilangeni','268','SZ','SWZ','748','.sz'),(1008,'166','Sweden','Kingdom of Sweden','Independent State',NULL,NULL,'Stockholm','SEK','Kronoa','46','SE','SWE','752','.se'),(1009,'167','Switzerland','Swiss Confederation','Independent State',NULL,NULL,'Bern','CHF','Franc','41','CH','CHE','756','.ch'),(1010,'168','Syria','Syrian Arab Republic','Independent State',NULL,NULL,'Damascus','SYP','Pound','963','SY','SYR','760','.sy'),(1011,'169','Tajikistan','Republic of Tajikistan','Independent State',NULL,NULL,'Dushanbe','TJS','Somoni','992','TJ','TJK','762','.tj'),(1012,'170','Tanzania','United Republic of Tanzania','Independent State',NULL,NULL,'Dar es Salaam (administrative/judical) and Dodoma (legislative)','TZS','Shilling','255','TZ','TZA','834','.tz'),(1013,'171','Thailand','Kingdom of Thailand','Independent State',NULL,NULL,'Bangkok','THB','Baht','66','TH','THA','764','.th'),(1014,'172','Timor-Leste (East Timor)','Democratic Republic of Timor-Leste','Independent State',NULL,NULL,'Dili','USD','Dollar','670','TL','TLS','626','.tp and .tl'),(1015,'173','Togo','Togolese Republic','Independent State',NULL,NULL,'Lome','XOF','Franc','228','TG','TGO','768','.tg'),(1016,'174','Tonga','Kingdom of Tonga','Independent State',NULL,NULL,'Nuku\'alofa','TOP','Pa\'anga','676','TO','TON','776','.to'),(1017,'175','Trinidad and Tobago','Republic of Trinidad and Tobago','Independent State',NULL,NULL,'Port-of-Spain','TTD','Dollar','-867','TT','TTO','780','.tt'),(1018,'176','Tunisia','Tunisian Republic','Independent State',NULL,NULL,'Tunis','TND','Dinar','216','TN','TUN','788','.tn'),(1019,'177','Turkey','Republic of Turkey','Independent State',NULL,NULL,'Ankara','TRY','Lira','90','TR','TUR','792','.tr'),(1020,'178','Turkmenistan',NULL,'Independent State',NULL,NULL,'Ashgabat','TMM','Manat','993','TM','TKM','795','.tm'),(1021,'179','Tuvalu',NULL,'Independent State',NULL,NULL,'Funafuti','AUD','Dollar','688','TV','TUV','798','.tv'),(1022,'180','Uganda','Republic of Uganda','Independent State',NULL,NULL,'Kampala','UGX','Shilling','256','UG','UGA','800','.ug'),(1023,'181','Ukraine',NULL,'Independent State',NULL,NULL,'Kiev','UAH','Hryvnia','380','UA','UKR','804','.ua'),(1024,'182','United Arab Emirates','United Arab Emirates','Independent State',NULL,NULL,'Abu Dhabi','AED','Dirham','971','AE','ARE','784','.ae'),(1025,'183','United Kingdom','United Kingdom of Great Britain and Northern Ireland','Independent State',NULL,NULL,'London','GBP','Pound','44','GB','GBR','826','.uk'),(1026,'184','United States','United States of America','Independent State',NULL,NULL,'Washington','USD','Dollar','1','US','USA','840','.us'),(1027,'185','Uruguay','Oriental Republic of Uruguay','Independent State',NULL,NULL,'Montevideo','UYU','Peso','598','UY','URY','858','.uy'),(1028,'186','Uzbekistan','Republic of Uzbekistan','Independent State',NULL,NULL,'Tashkent','UZS','Som','998','UZ','UZB','860','.uz'),(1029,'187','Vanuatu','Republic of Vanuatu','Independent State',NULL,NULL,'Port-Vila','VUV','Vatu','678','VU','VUT','548','.vu'),(1030,'188','Vatican City','State of the Vatican City','Independent State',NULL,NULL,'Vatican City','EUR','Euro','379','VA','VAT','336','.va'),(1031,'189','Venezuela','Bolivarian Republic of Venezuela','Independent State',NULL,NULL,'Caracas','VEB','Bolivar','58','VE','VEN','862','.ve'),(1032,'190','Vietnam','Socialist Republic of Vietnam','Independent State',NULL,NULL,'Hanoi','VND','Dong','84','VN','VNM','704','.vn'),(1033,'191','Yemen','Republic of Yemen','Independent State',NULL,NULL,'Sanaa','YER','Rial','967','YE','YEM','887','.ye'),(1034,'192','Zambia','Republic of Zambia','Independent State',NULL,NULL,'Lusaka','ZMK','Kwacha','260','ZM','ZMB','894','.zm'),(1035,'193','Zimbabwe','Republic of Zimbabwe','Independent State',NULL,NULL,'Harare','ZWD','Dollar','263','ZW','ZWE','716','.zw'),(1036,'194','Abkhazia','Republic of Abkhazia','Proto Independent State',NULL,NULL,'Sokhumi','RUB','Ruble','995','GE','GEO','268','.ge'),(1037,'195','China, Republic of (Taiwan)','Republic of China','Proto Independent State',NULL,NULL,'Taipei','TWD','Dollar','886','TW','TWN','158','.tw'),(1038,'196','Nagorno-Karabakh','Nagorno-Karabakh Republic','Proto Independent State',NULL,NULL,'Stepanakert','AMD','Dram','277','AZ','AZE','31','.az'),(1039,'197','Northern Cyprus','Turkish Republic of Northern Cyprus','Proto Independent State',NULL,NULL,'Nicosia','TRY','Lira','-302','CY','CYP','196','.nc.tr'),(1040,'198','Pridnestrovie (Transnistria)','Pridnestrovian Moldavian Republic','Proto Independent State',NULL,NULL,'Tiraspol',NULL,'Ruple','-160','MD','MDA','498','.md'),(1041,'199','Somaliland','Republic of Somaliland','Proto Independent State',NULL,NULL,'Hargeisa',NULL,'Shilling','252','SO','SOM','706','.so'),(1042,'200','South Ossetia','Republic of South Ossetia','Proto Independent State',NULL,NULL,'Tskhinvali','RUB and GEL','Ruble and Lari','995','GE','GEO','268','.ge'),(1043,'201','Ashmore and Cartier Islands','Territory of Ashmore and Cartier Islands','Dependency','External Territory','Australia',NULL,NULL,NULL,NULL,'AU','AUS','36','.au'),(1044,'202','Christmas Island','Territory of Christmas Island','Dependency','External Territory','Australia','The Settlement (Flying Fish Cove)','AUD','Dollar','61','CX','CXR','162','.cx'),(1045,'203','Cocos (Keeling) Islands','Territory of Cocos (Keeling) Islands','Dependency','External Territory','Australia','West Island','AUD','Dollar','61','CC','CCK','166','.cc'),(1046,'204','Coral Sea Islands','Coral Sea Islands Territory','Dependency','External Territory','Australia',NULL,NULL,NULL,NULL,'AU','AUS','36','.au'),(1047,'205','Heard Island and McDonald Islands','Territory of Heard Island and McDonald Islands','Dependency','External Territory','Australia',NULL,NULL,NULL,NULL,'HM','HMD','334','.hm'),(1048,'206','Norfolk Island','Territory of Norfolk Island','Dependency','External Territory','Australia','Kingston','AUD','Dollar','672','NF','NFK','574','.nf'),(1049,'207','New Caledonia',NULL,'Dependency','Sui generis Collectivity','France','Noumea','XPF','Franc','687','NC','NCL','540','.nc'),(1050,'208','French Polynesia','Overseas Country of French Polynesia','Dependency','Overseas Collectivity','France','Papeete','XPF','Franc','689','PF','PYF','258','.pf'),(1051,'209','Mayotte','Departmental Collectivity of Mayotte','Dependency','Overseas Collectivity','France','Mamoudzou','EUR','Euro','262','YT','MYT','175','.yt'),(1052,'210','Saint Barthelemy','Collectivity of Saint Barthelemy','Dependency','Overseas Collectivity','France','Gustavia','EUR','Euro','590','GP','GLP','312','.gp'),(1053,'211','Saint Martin','Collectivity of Saint Martin','Dependency','Overseas Collectivity','France','Marigot','EUR','Euro','590','GP','GLP','312','.gp'),(1054,'212','Saint Pierre and Miquelon','Territorial Collectivity of Saint Pierre and Miquelon','Dependency','Overseas Collectivity','France','Saint-Pierre','EUR','Euro','508','PM','SPM','666','.pm'),(1055,'213','Wallis and Futuna','Collectivity of the Wallis and Futuna Islands','Dependency','Overseas Collectivity','France','Mata\'utu','XPF','Franc','681','WF','WLF','876','.wf'),(1056,'214','French Southern and Antarctic Lands','Territory of the French Southern and Antarctic Lands','Dependency','Overseas Territory','France','Martin-de-ViviÃ¨s',NULL,NULL,NULL,'TF','ATF','260','.tf'),(1057,'215','Clipperton Island',NULL,'Dependency','Possession','France',NULL,NULL,NULL,NULL,'PF','PYF','258','.pf'),(1058,'216','Bouvet Island',NULL,'Dependency','Territory','Norway',NULL,NULL,NULL,NULL,'BV','BVT','74','.bv'),(1059,'217','Cook Islands',NULL,'Dependency','Self-Governing in Free Association','New Zealand','Avarua','NZD','Dollar','682','CK','COK','184','.ck'),(1060,'218','Niue',NULL,'Dependency','Self-Governing in Free Association','New Zealand','Alofi','NZD','Dollar','683','NU','NIU','570','.nu'),(1061,'219','Tokelau',NULL,'Dependency','Territory','New Zealand',NULL,'NZD','Dollar','690','TK','TKL','772','.tk'),(1062,'220','Guernsey','Bailiwick of Guernsey','Dependency','Crown Dependency','United Kingdom','Saint Peter Port','GGP','Pound','44','GG','GGY','831','.gg'),(1063,'221','Isle of Man',NULL,'Dependency','Crown Dependency','United Kingdom','Douglas','IMP','Pound','44','IM','IMN','833','.im'),(1064,'222','Jersey','Bailiwick of Jersey','Dependency','Crown Dependency','United Kingdom','Saint Helier','JEP','Pound','44','JE','JEY','832','.je'),(1065,'223','Anguilla',NULL,'Dependency','Overseas Territory','United Kingdom','The Valley','XCD','Dollar','-263','AI','AIA','660','.ai'),(1066,'224','Bermuda',NULL,'Dependency','Overseas Territory','United Kingdom','Hamilton','BMD','Dollar','-440','BM','BMU','60','.bm'),(1067,'225','British Indian Ocean Territory',NULL,'Dependency','Overseas Territory','United Kingdom',NULL,NULL,NULL,'246','IO','IOT','86','.io'),(1068,'226','British Sovereign Base Areas',NULL,'Dependency','Overseas Territory','United Kingdom','Episkopi','CYP','Pound','357',NULL,NULL,NULL,NULL),(1069,'227','British Virgin Islands',NULL,'Dependency','Overseas Territory','United Kingdom','Road Town','USD','Dollar','-283','VG','VGB','92','.vg'),(1070,'228','Cayman Islands',NULL,'Dependency','Overseas Territory','United Kingdom','George Town','KYD','Dollar','-344','KY','CYM','136','.ky'),(1071,'229','Falkland Islands (Islas Malvinas)',NULL,'Dependency','Overseas Territory','United Kingdom','Stanley','FKP','Pound','500','FK','FLK','238','.fk'),(1072,'230','Gibraltar',NULL,'Dependency','Overseas Territory','United Kingdom','Gibraltar','GIP','Pound','350','GI','GIB','292','.gi'),(1073,'231','Montserrat',NULL,'Dependency','Overseas Territory','United Kingdom','Plymouth','XCD','Dollar','-663','MS','MSR','500','.ms'),(1074,'232','Pitcairn Islands',NULL,'Dependency','Overseas Territory','United Kingdom','Adamstown','NZD','Dollar',NULL,'PN','PCN','612','.pn'),(1075,'233','Saint Helena',NULL,'Dependency','Overseas Territory','United Kingdom','Jamestown','SHP','Pound','290','SH','SHN','654','.sh'),(1076,'234','South Georgia & South Sandwich Islands',NULL,'Dependency','Overseas Territory','United Kingdom',NULL,NULL,NULL,NULL,'GS','SGS','239','.gs'),(1077,'235','Turks and Caicos Islands',NULL,'Dependency','Overseas Territory','United Kingdom','Grand Turk','USD','Dollar','-648','TC','TCA','796','.tc'),(1078,'236','Northern Mariana Islands','Commonwealth of The Northern Mariana Islands','Dependency','Commonwealth','United States','Saipan','USD','Dollar','-669','MP','MNP','580','.mp'),(1079,'237','Puerto Rico','Commonwealth of Puerto Rico','Dependency','Commonwealth','United States','San Juan','USD','Dollar','+1-787 and 1-939','PR','PRI','630','.pr'),(1080,'238','American Samoa','Territory of American Samoa','Dependency','Territory','United States','Pago Pago','USD','Dollar','-683','AS','ASM','16','.as'),(1081,'239','Baker Island',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1082,'240','Guam','Territory of Guam','Dependency','Territory','United States','Hagatna','USD','Dollar','-670','GU','GUM','316','.gu'),(1083,'241','Howland Island',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1084,'242','Jarvis Island',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1085,'243','Johnston Atoll',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1086,'244','Kingman Reef',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1087,'245','Midway Islands',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1088,'246','Navassa Island',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1089,'247','Palmyra Atoll',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','581',NULL),(1090,'248','U.S. Virgin Islands','United States Virgin Islands','Dependency','Territory','United States','Charlotte Amalie','USD','Dollar','-339','VI','VIR','850','.vi'),(1091,'249','Wake Island',NULL,'Dependency','Territory','United States',NULL,NULL,NULL,NULL,'UM','UMI','850',NULL),(1092,'250','Hong Kong','Hong Kong Special Administrative Region','Proto Dependency','Special Administrative Region','China',NULL,'HKD','Dollar','852','HK','HKG','344','.hk'),(1093,'251','Macau','Macau Special Administrative Region','Proto Dependency','Special Administrative Region','China','Macau','MOP','Pataca','853','MO','MAC','446','.mo'),(1094,'252','Faroe Islands',NULL,'Proto Dependency',NULL,'Denmark','Torshavn','DKK','Krone','298','FO','FRO','234','.fo'),(1095,'253','Greenland',NULL,'Proto Dependency',NULL,'Denmark','Nuuk (Godthab)','DKK','Krone','299','GL','GRL','304','.gl'),(1096,'254','French Guiana','Overseas Region of Guiana','Proto Dependency','Overseas Region','France','Cayenne','EUR','Euro','594','GF','GUF','254','.gf'),(1097,'255','Guadeloupe','Overseas Region of Guadeloupe','Proto Dependency','Overseas Region','France','Basse-Terre','EUR','Euro','590','GP','GLP','312','.gp'),(1098,'256','Martinique','Overseas Region of Martinique','Proto Dependency','Overseas Region','France','Fort-de-France','EUR','Euro','596','MQ','MTQ','474','.mq'),(1099,'257','Reunion','Overseas Region of Reunion','Proto Dependency','Overseas Region','France','Saint-Denis','EUR','Euro','262','RE','REU','638','.re'),(1100,'258','Aland',NULL,'Proto Dependency',NULL,'Finland','Mariehamn','EUR','Euro','340','AX','ALA','248','.ax'),(1101,'259','Aruba',NULL,'Proto Dependency',NULL,'Netherlands','Oranjestad','AWG','Guilder','297','AW','ABW','533','.aw'),(1102,'260','Netherlands Antilles',NULL,'Proto Dependency',NULL,'Netherlands','Willemstad','ANG','Guilder','599','AN','ANT','530','.an'),(1103,'261','Svalbard',NULL,'Proto Dependency',NULL,'Norway','Longyearbyen','NOK','Krone','47','SJ','SJM','744','.sj'),(1104,'262','Ascension',NULL,'Proto Dependency','Dependency of Saint Helena','United Kingdom','Georgetown','SHP','Pound','247','AC','ASC',NULL,'.ac'),(1105,'263','Tristan da Cunha',NULL,'Proto Dependency','Dependency of Saint Helena','United Kingdom','Edinburgh','SHP','Pound','290','TA','TAA',NULL,NULL),(1106,'268','Australian Antarctic Territory',NULL,'Antarctic Territory','External Territory','Australia',NULL,NULL,NULL,NULL,'AQ','ATA','10','.aq'),(1107,'269','Ross Dependency',NULL,'Antarctic Territory','Territory','New Zealand',NULL,NULL,NULL,NULL,'AQ','ATA','10','.aq'),(1108,'270','Peter I Island',NULL,'Antarctic Territory','Territory','Norway',NULL,NULL,NULL,NULL,'AQ','ATA','10','.aq'),(1109,'271','Queen Maud Land',NULL,'Antarctic Territory','Territory','Norway',NULL,NULL,NULL,NULL,'AQ','ATA','10','.aq'),(1110,'272','British Antarctic Territory',NULL,'Antarctic Territory','Overseas Territory','United Kingdom',NULL,NULL,NULL,NULL,'AQ','ATA','10','.aq');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) DEFAULT NULL,
  `description` varchar(2048) DEFAULT NULL,
  `doctype` varchar(1024) DEFAULT NULL,
  `code` text,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_attributes`
--

DROP TABLE IF EXISTS `exchange_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_id` int(11) DEFAULT NULL,
  `banner_video_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `exchange` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_exchange_attributes_on_banner_id` (`banner_id`),
  KEY `index_exchange_attributes_on_banner_video_id` (`banner_video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_attributes`
--

LOCK TABLES `exchange_attributes` WRITE;
/*!40000 ALTER TABLE `exchange_attributes` DISABLE KEYS */;
INSERT INTO `exchange_attributes` VALUES (38,NULL,NULL,'appnexus_crid','','2017-04-25 19:59:54','2017-04-25 19:59:54','appnexus'),(39,NULL,NULL,'appnexus_crid','','2017-04-25 20:37:16','2017-04-25 20:37:16','appnexus');
/*!40000 ALTER TABLE `exchange_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_rtbspecs`
--

DROP TABLE IF EXISTS `exchange_rtbspecs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_rtbspecs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rtbspecification` varchar(1024) DEFAULT NULL,
  `operand_type` varchar(1024) DEFAULT NULL,
  `operand_ordinal` varchar(1024) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_rtbspecs`
--

LOCK TABLES `exchange_rtbspecs` WRITE;
/*!40000 ALTER TABLE `exchange_rtbspecs` DISABLE KEYS */;
INSERT INTO `exchange_rtbspecs` VALUES (1,'request.app.id','String','Scalar',NULL,NULL),(2,'request.app.name','String','Scalar',NULL,NULL),(3,'request.app.bundle','String','Scalar',NULL,NULL),(4,'request.app.domain','String','Scalar',NULL,NULL),(5,'request.app.storeurl','String','Scalar',NULL,NULL),(6,'request.app.storeurl','String','Scalar',NULL,NULL),(7,'request.app.cat','String','List',NULL,NULL),(8,'request.app.sectioncat','String','List',NULL,NULL),(9,'request.app.pagecat','String','List',NULL,NULL),(10,'request.app.ver','String','Scalar',NULL,NULL),(11,'request.app.privacypolicy','Integer','Scalar',NULL,NULL),(12,'request.app.paid','Integer','Scalar',NULL,NULL),(13,'request.app.keywords','String','Scalar',NULL,NULL);
/*!40000 ALTER TABLE `exchange_rtbspecs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_smarty_ads_rtbspecs`
--

DROP TABLE IF EXISTS `exchange_smarty_ads_rtbspecs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_smarty_ads_rtbspecs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rtbspecification` varchar(1024) DEFAULT NULL,
  `operand_type` varchar(1024) DEFAULT NULL,
  `operand_ordinal` varchar(1024) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_smarty_ads_rtbspecs`
--

LOCK TABLES `exchange_smarty_ads_rtbspecs` WRITE;
/*!40000 ALTER TABLE `exchange_smarty_ads_rtbspecs` DISABLE KEYS */;
/*!40000 ALTER TABLE `exchange_smarty_ads_rtbspecs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iab_categories`
--

DROP TABLE IF EXISTS `iab_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iab_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` text,
  `name` text,
  `iab_id` text,
  `is_group` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=811 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iab_categories`
--

LOCK TABLES `iab_categories` WRITE;
/*!40000 ALTER TABLE `iab_categories` DISABLE KEYS */;
INSERT INTO `iab_categories` VALUES (419,'Arts & Entertainment','Arts & Entertainment','IAB1',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(420,'Arts & Entertainment','Books & Literature','IAB1-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(421,'Arts & Entertainment','Celebrity Fan/Gossip','IAB1-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(422,'Arts & Entertainment','Fine Art','IAB1-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(423,'Arts & Entertainment','Humor','IAB1-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(424,'Arts & Entertainment','Movies','IAB1-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(425,'Arts & Entertainment','Music','IAB1-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(426,'Arts & Entertainment','Television','IAB1-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(427,'Automotive','Automotive','IAB2',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(428,'Automotive','Auto Parts','IAB2-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(429,'Automotive','Auto Repair','IAB2-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(430,'Automotive','Buying/Selling Cars','IAB2-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(431,'Automotive','Car Culture','IAB2-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(432,'Automotive','Certified Pre-Owned','IAB2-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(433,'Automotive','Convertible','IAB2-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(434,'Automotive','Coupe','IAB2-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(435,'Automotive','Crossover','IAB2-8',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(436,'Automotive','Diesel','IAB2-9',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(437,'Automotive','Electric Vehicle','IAB2-10',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(438,'Automotive','Hatchback','IAB2-11',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(439,'Automotive','Hybrid','IAB2-12',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(440,'Automotive','Luxury','IAB2-13',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(441,'Automotive','MiniVan','IAB2-14',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(442,'Automotive','Mororcycles','IAB2-15',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(443,'Automotive','Off-Road Vehicles','IAB2-16',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(444,'Automotive','Performance Vehicles','IAB2-17',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(445,'Automotive','Pickup','IAB2-18',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(446,'Automotive','Road-Side Assistance','IAB2-19',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(447,'Automotive','Sedan','IAB2-20',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(448,'Automotive','Trucks & Accessories','IAB2-21',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(449,'Automotive','Vintage Cars','IAB2-22',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(450,'Automotive','Wagon','IAB2-23',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(451,'Business','Business','IAB3',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(452,'Business','Advertising','IAB3-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(453,'Business','Agriculture','IAB3-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(454,'Business','Biotech/Biomedical','IAB3-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(455,'Business','Business Software','IAB3-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(456,'Business','Construction','IAB3-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(457,'Business','Forestry','IAB3-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(458,'Business','Government','IAB3-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(459,'Business','Green Solutions','IAB3-8',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(460,'Business','Human Resources','IAB3-9',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(461,'Business','Logistics','IAB3-10',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(462,'Business','Marketing','IAB3-11',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(463,'Business','Metals','IAB3-12',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(464,'Careers','Careers','IAB4',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(465,'Careers','Career Planning','IAB4-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(466,'Careers','College','IAB4-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(467,'Careers','Financial Aid','IAB4-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(468,'Careers','Job Fairs','IAB4-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(469,'Careers','Job Search','IAB4-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(470,'Careers','Resume Writing/Advice','IAB4-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(471,'Careers','Nursing','IAB4-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(472,'Careers','Scholarships','IAB4-8',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(473,'Careers','Telecommuting','IAB4-9',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(474,'Careers','U.S. Military','IAB4-10',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(475,'Careers','Career Advice','IAB4-11',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(476,'Education','Education','IAB5',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(477,'Education','7-12 Education','IAB5-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(478,'Education','Adult Education','IAB5-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(479,'Education','Art History','IAB5-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(480,'Education','Colledge Administration','IAB5-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(481,'Education','College Life','IAB5-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(482,'Education','Distance Learning','IAB5-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(483,'Education','English as a 2nd Language','IAB5-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(484,'Education','Language Learning','IAB5-8',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(485,'Education','Graduate School','IAB5-9',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(486,'Education','Homeschooling','IAB5-10',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(487,'Education','Homework/Study Tips','IAB5-11',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(488,'Education','K-6 Educators','IAB5-12',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(489,'Education','Private School','IAB5-13',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(490,'Education','Special Education','IAB5-14',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(491,'Education','Studying Business','IAB5-15',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(492,'Family & Parenting','Family & Parenting','IAB6',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(493,'Family & Parenting','Adoption','IAB6-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(494,'Family & Parenting','Babies & Toddlers','IAB6-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(495,'Family & Parenting','Daycare/Pre School','IAB6-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(496,'Family & Parenting','Family Internet','IAB6-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(497,'Family & Parenting','Parenting - K-6 Kids','IAB6-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(498,'Family & Parenting','Parenting teens','IAB6-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(499,'Family & Parenting','Pregnancy','IAB6-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(500,'Family & Parenting','Special Needs Kids','IAB6-8',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(501,'Family & Parenting','Eldercare','IAB6-9',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(502,'Health & Fitness','Health & Fitness','IAB7',1,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(503,'Health & Fitness','Exercise','IAB7-1',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(504,'Health & Fitness','A.D.D.','IAB7-2',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(505,'Health & Fitness','AIDS/HIV','IAB7-3',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(506,'Health & Fitness','Allergies','IAB7-4',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(507,'Health & Fitness','Alternative Medicine','IAB7-5',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(508,'Health & Fitness','Arthritis','IAB7-6',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(509,'Health & Fitness','Asthma','IAB7-7',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(510,'Health & Fitness','Autism/PDD','IAB7-8',0,'2016-10-20 20:31:32','2016-10-20 20:31:32'),(511,'Health & Fitness','Bipolar Disorder','IAB7-9',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(512,'Health & Fitness','Brain Tumor','IAB7-10',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(513,'Health & Fitness','Cancer','IAB7-11',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(514,'Health & Fitness','Cholesterol','IAB7-12',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(515,'Health & Fitness','Chronic Fatigue Syndrome','IAB7-13',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(516,'Health & Fitness','Chronic Pain','IAB7-14',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(517,'Health & Fitness','Cold & Flu','IAB7-15',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(518,'Health & Fitness','Deafness','IAB7-16',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(519,'Health & Fitness','Dental Care','IAB7-17',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(520,'Health & Fitness','Depression','IAB7-18',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(521,'Health & Fitness','Dermatology','IAB7-19',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(522,'Health & Fitness','Diabetes','IAB7-20',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(523,'Health & Fitness','Epilepsy','IAB7-21',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(524,'Health & Fitness','GERD/Acid Reflux','IAB7-22',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(525,'Health & Fitness','Headaches/Migraines','IAB7-23',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(526,'Health & Fitness','Heart Disease','IAB7-24',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(527,'Health & Fitness','Herbs for Health','IAB7-25',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(528,'Health & Fitness','Holistic Healing','IAB7-26',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(529,'Health & Fitness','IBS/Crohn\'s Disease','IAB7-27',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(530,'Health & Fitness','Incest/Abuse Support','IAB7-28',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(531,'Health & Fitness','Incontinence','IAB7-29',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(532,'Health & Fitness','Infertility','IAB7-30',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(533,'Health & Fitness','Men\'s Health','IAB7-31',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(534,'Health & Fitness','Nutrition','IAB7-32',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(535,'Health & Fitness','Orthopedics','IAB7-33',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(536,'Health & Fitness','Panic/Anxiety Disorders','IAB7-34',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(537,'Health & Fitness','Pediatrics','IAB7-35',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(538,'Health & Fitness','Physical Therapy','IAB7-36',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(539,'Health & Fitness','Psychology/Psychiatry','IAB7-37',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(540,'Health & Fitness','Senor Health','IAB7-38',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(541,'Health & Fitness','Sexuality','IAB7-39',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(542,'Health & Fitness','Sleep Disorders','IAB7-40',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(543,'Health & Fitness','Smoking Cessation','IAB7-41',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(544,'Health & Fitness','Substance Abuse','IAB7-42',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(545,'Health & Fitness','Thyroid Disease','IAB7-43',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(546,'Health & Fitness','Weight Loss','IAB7-44',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(547,'Health & Fitness','Women\'s Health','IAB7-45',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(548,'Food & Drink','Food & Drink','IAB8',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(549,'Food & Drink','American Cuisine','IAB8-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(550,'Food & Drink','Barbecues & Grilling','IAB8-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(551,'Food & Drink','Cajun/Creole','IAB8-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(552,'Food & Drink','Chinese Cuisine','IAB8-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(553,'Food & Drink','Cocktails/Beer','IAB8-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(554,'Food & Drink','Coffee/Tea','IAB8-6',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(555,'Food & Drink','Cuisine-Specific','IAB8-7',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(556,'Food & Drink','Desserts & Baking','IAB8-8',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(557,'Food & Drink','Dining Out','IAB8-9',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(558,'Food & Drink','Food Allergies','IAB8-10',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(559,'Food & Drink','French Cuisine','IAB8-11',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(560,'Food & Drink','Health/Lowfat Cooking','IAB8-12',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(561,'Food & Drink','Italian Cuisine','IAB8-13',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(562,'Food & Drink','Japanese Cuisine','IAB8-14',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(563,'Food & Drink','Mexican Cuisine','IAB8-15',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(564,'Food & Drink','Vegan','IAB8-16',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(565,'Food & Drink','Vegetarian','IAB8-17',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(566,'Food & Drink','Wine','IAB8-18',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(567,'Hobbies & Interests','Hobbies & Interests','IAB9',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(568,'Hobbies & Interests','Art/Technology','IAB9-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(569,'Hobbies & Interests','Arts & Crafts','IAB9-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(570,'Hobbies & Interests','Beadwork','IAB9-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(571,'Hobbies & Interests','Birdwatching','IAB9-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(572,'Hobbies & Interests','Board Games/Puzzles','IAB9-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(573,'Hobbies & Interests','Candle & Soap Making','IAB9-6',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(574,'Hobbies & Interests','Card Games','IAB9-7',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(575,'Hobbies & Interests','Chess','IAB9-8',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(576,'Hobbies & Interests','Cigars','IAB9-9',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(577,'Hobbies & Interests','Collecting','IAB9-10',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(578,'Hobbies & Interests','Comic Books','IAB9-11',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(579,'Hobbies & Interests','Drawing/Sketching','IAB9-12',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(580,'Hobbies & Interests','Freelance Writing','IAB9-13',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(581,'Hobbies & Interests','Genealogy','IAB9-14',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(582,'Hobbies & Interests','Getting Published','IAB9-15',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(583,'Hobbies & Interests','Guitar','IAB9-16',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(584,'Hobbies & Interests','Home Recording','IAB9-17',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(585,'Hobbies & Interests','Investors & Patents','IAB9-18',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(586,'Hobbies & Interests','Jewelry Making','IAB9-19',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(587,'Hobbies & Interests','Magic & Illusion','IAB9-20',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(588,'Hobbies & Interests','Needlework','IAB9-21',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(589,'Hobbies & Interests','Painting','IAB9-22',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(590,'Hobbies & Interests','Photography','IAB9-23',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(591,'Hobbies & Interests','Radio','IAB9-24',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(592,'Hobbies & Interests','Roleplaying Games','IAB9-25',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(593,'Hobbies & Interests','Sci-Fi & Fantasy','IAB9-26',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(594,'Hobbies & Interests','Scrapbooking','IAB9-27',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(595,'Hobbies & Interests','Screenwriting','IAB9-28',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(596,'Hobbies & Interests','Stamps & Coins','IAB9-29',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(597,'Hobbies & Interests','Video & Computer Games','IAB9-30',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(598,'Hobbies & Interests','Woodworking','IAB9-31',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(599,'Home & Garden','Home & Garden','IAB10',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(600,'Home & Garden','Appliances','IAB10-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(601,'Home & Garden','Entertaining','IAB10-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(602,'Home & Garden','Environmental Safety','IAB10-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(603,'Home & Garden','Gardening','IAB10-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(604,'Home & Garden','Home Repair','IAB10-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(605,'Home & Garden','Home Theater','IAB10-6',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(606,'Home & Garden','Interior Decorating','IAB10-7',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(607,'Home & Garden','Landscaping','IAB10-8',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(608,'Home & Garden','Remodeling & Construction','IAB10-9',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(609,'Law, Gov\'t & Politics','Law, Gov\'t & Politics','IAB11',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(610,'Law, Gov\'t & Politics','Immigration','IAB11-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(611,'Law, Gov\'t & Politics','Legal Issues','IAB11-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(612,'Law, Gov\'t & Politics','U.S. Government Resources','IAB11-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(613,'Law, Gov\'t & Politics','Politics','IAB11-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(614,'Law, Gov\'t & Politics','Commentary','IAB11-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(615,'News','News','IAB12',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(616,'News','International News','IAB12-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(617,'News','National News','IAB12-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(618,'News','Local News','IAB12-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(619,'Personal Finance','Personal Finance','IAB13',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(620,'Personal Finance','Beginning Investing','IAB13-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(621,'Personal Finance','Credit/Debt & Loans','IAB13-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(622,'Personal Finance','Financial News','IAB13-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(623,'Personal Finance','Financial Planning','IAB13-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(624,'Personal Finance','Hedge Fund','IAB13-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(625,'Personal Finance','Insurance','IAB13-6',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(626,'Personal Finance','Investing','IAB13-7',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(627,'Personal Finance','Mutual Funds','IAB13-8',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(628,'Personal Finance','Options','IAB13-9',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(629,'Personal Finance','Retirement Planning','IAB13-10',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(630,'Personal Finance','Stocks','IAB13-11',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(631,'Personal Finance','Tax Planning','IAB13-12',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(632,'Society','Society','IAB14',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(633,'Society','Dating','IAB14-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(634,'Society','Divorce Support','IAB14-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(635,'Society','Gay Life','IAB14-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(636,'Society','Marriage','IAB14-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(637,'Society','Senior Living','IAB14-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(638,'Society','Teens','IAB14-6',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(639,'Society','Weddings','IAB14-7',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(640,'Society','Ethnic Specific','IAB14-8',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(641,'Science','Science','IAB15',1,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(642,'Science','Astrology','IAB15-1',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(643,'Science','Biology','IAB15-2',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(644,'Science','Chemistry','IAB15-3',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(645,'Science','Geology','IAB15-4',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(646,'Science','Paranormal Phenomena','IAB15-5',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(647,'Science','Physics','IAB15-6',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(648,'Science','Space/Astronomy','IAB15-7',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(649,'Science','Geography','IAB15-8',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(650,'Science','Botany','IAB15-9',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(651,'Science','Weather','IAB15-10',0,'2016-10-20 20:31:33','2016-10-20 20:31:33'),(652,'Pets','Pets','IAB16',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(653,'Pets','Aquariums','IAB16-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(654,'Pets','Birds','IAB16-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(655,'Pets','Cats','IAB16-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(656,'Pets','Dogs','IAB16-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(657,'Pets','Large Animals','IAB16-5',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(658,'Pets','Reptiles','IAB16-6',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(659,'Pets','Veterinary Medicine','IAB16-7',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(660,'Sports','Sports','IAB17',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(661,'Sports','Auto Racing','IAB17-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(662,'Sports','Baseball','IAB17-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(663,'Sports','Bicycling','IAB17-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(664,'Sports','Bodybuilding','IAB17-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(665,'Sports','Boxing','IAB17-5',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(666,'Sports','Canoeing/Kayaking','IAB17-6',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(667,'Sports','Cheerleading','IAB17-7',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(668,'Sports','Climbing','IAB17-8',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(669,'Sports','Cricket','IAB17-9',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(670,'Sports','Figure Skating','IAB17-10',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(671,'Sports','Fly Fishing','IAB17-11',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(672,'Sports','Football','IAB17-12',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(673,'Sports','Freshwater Fishing','IAB17-13',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(674,'Sports','Game & Fish','IAB17-14',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(675,'Sports','Golf','IAB17-15',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(676,'Sports','Horse Racing','IAB17-16',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(677,'Sports','Horses','IAB17-17',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(678,'Sports','Hunting/Shooting','IAB17-18',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(679,'Sports','Inline Skating','IAB17-19',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(680,'Sports','Martial Arts','IAB17-20',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(681,'Sports','Mountain Biking','IAB17-21',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(682,'Sports','NASCAR Racing','IAB17-22',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(683,'Sports','Olympics','IAB17-23',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(684,'Sports','Paintball','IAB17-24',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(685,'Sports','Power & Motorcycles','IAB17-25',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(686,'Sports','Pro Basketball','IAB17-26',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(687,'Sports','Pro Ice Hockey','IAB17-27',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(688,'Sports','Rodeo','IAB17-28',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(689,'Sports','Rugby','IAB17-29',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(690,'Sports','Running/Jogging','IAB17-30',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(691,'Sports','Sailing','IAB17-31',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(692,'Sports','Saltwater Fishing','IAB17-32',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(693,'Sports','Scuba Diving','IAB17-33',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(694,'Sports','Skateboarding','IAB17-34',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(695,'Sports','Skiing','IAB17-35',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(696,'Sports','Snowboarding','IAB17-36',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(697,'Sports','Surfing/Bodyboarding','IAB17-37',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(698,'Sports','Swimming','IAB17-38',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(699,'Sports','Table Tennis/Ping-Pong','IAB17-39',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(700,'Sports','Tennis','IAB17-40',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(701,'Sports','Volleyball','IAB17-41',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(702,'Sports','Walking','IAB17-42',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(703,'Sports','Waterski/Wakeboard','IAB17-43',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(704,'Sports','World Soccer','IAB17-44',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(705,'Style & Fashion','Style & Fashion','IAB18',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(706,'Style & Fashion','Beauty','IAB18-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(707,'Style & Fashion','Body Art','IAB18-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(708,'Style & Fashion','Fashion','IAB18-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(709,'Style & Fashion','Jewelry','IAB18-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(710,'Style & Fashion','Clothing','IAB18-5',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(711,'Style & Fashion','Accessories','IAB18-6',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(712,'Technology & Computing','Technology & Computing','IAB19',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(713,'Technology & Computing','3-D Graphics','IAB19-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(714,'Technology & Computing','Animation','IAB19-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(715,'Technology & Computing','Antivirus Software','IAB19-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(716,'Technology & Computing','C/C++','IAB19-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(717,'Technology & Computing','Cameras & Camcorders','IAB19-5',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(718,'Technology & Computing','Cell Phones','IAB19-6',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(719,'Technology & Computing','Computer Certification','IAB19-7',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(720,'Technology & Computing','Computer Networking','IAB19-8',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(721,'Technology & Computing','Computer Peripherals','IAB19-9',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(722,'Technology & Computing','Computer Reviews','IAB19-10',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(723,'Technology & Computing','Data Centers','IAB19-11',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(724,'Technology & Computing','Databases','IAB19-12',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(725,'Technology & Computing','Desktop Publishing','IAB19-13',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(726,'Technology & Computing','Desktop Video','IAB19-14',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(727,'Technology & Computing','Email','IAB19-15',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(728,'Technology & Computing','Graphics Software','IAB19-16',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(729,'Technology & Computing','Home Video/DVD','IAB19-17',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(730,'Technology & Computing','Internet Technology','IAB19-18',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(731,'Technology & Computing','Java','IAB19-19',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(732,'Technology & Computing','JavaScript','IAB19-20',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(733,'Technology & Computing','Mac Support','IAB19-21',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(734,'Technology & Computing','MP3/MIDI','IAB19-22',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(735,'Technology & Computing','Net Conferencing','IAB19-23',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(736,'Technology & Computing','Net for Beginners','IAB19-24',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(737,'Technology & Computing','Network Security','IAB19-25',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(738,'Technology & Computing','Palmtops/PDAs','IAB19-26',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(739,'Technology & Computing','PC Support','IAB19-27',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(740,'Technology & Computing','Portable','IAB19-28',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(741,'Technology & Computing','Entertainment','IAB19-29',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(742,'Technology & Computing','Shareware/Freeware','IAB19-30',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(743,'Technology & Computing','Unix','IAB19-31',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(744,'Technology & Computing','Visual Basic','IAB19-32',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(745,'Technology & Computing','Web Clip Art','IAB19-33',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(746,'Technology & Computing','Web Design/HTML','IAB19-34',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(747,'Technology & Computing','Web Search','IAB19-35',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(748,'Technology & Computing','Windows','IAB19-36',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(749,'Travel','Travel','IAB20',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(750,'Travel','Adventure Travel','IAB20-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(751,'Travel','Africa','IAB20-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(752,'Travel','Air Travel','IAB20-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(753,'Travel','Australia & New Zealand','IAB20-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(754,'Travel','Bed & Breakfasts','IAB20-5',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(755,'Travel','Budget Travel','IAB20-6',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(756,'Travel','Business Travel','IAB20-7',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(757,'Travel','By US Locale','IAB20-8',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(758,'Travel','Camping','IAB20-9',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(759,'Travel','Canada','IAB20-10',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(760,'Travel','Caribbean','IAB20-11',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(761,'Travel','Cruises','IAB20-12',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(762,'Travel','Eastern Europe','IAB20-13',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(763,'Travel','Europe','IAB20-14',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(764,'Travel','France','IAB20-15',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(765,'Travel','Greece','IAB20-16',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(766,'Travel','Honeymoons/Getaways','IAB20-17',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(767,'Travel','Hotels','IAB20-18',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(768,'Travel','Italy','IAB20-19',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(769,'Travel','Japan','IAB20-20',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(770,'Travel','Mexico & Central America','IAB20-21',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(771,'Travel','National Parks','IAB20-22',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(772,'Travel','South America','IAB20-23',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(773,'Travel','Spas','IAB20-24',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(774,'Travel','Theme Parks','IAB20-25',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(775,'Travel','Traveling with Kids','IAB20-26',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(776,'Travel','United Kingdom','IAB20-27',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(777,'Real Estate','Real Estate','IAB21',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(778,'Real Estate','Apartments','IAB21-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(779,'Real Estate','Architects','IAB21-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(780,'Real Estate','Buying/Selling Homes','IAB21-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(781,'Shopping','Shopping','IAB22',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(782,'Shopping','Contests & Freebies','IAB22-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(783,'Shopping','Couponing','IAB22-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(784,'Shopping','Comparison','IAB22-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(785,'Shopping','Engines','IAB22-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(786,'Religion & Spirituality','Religion & Spirituality','IAB23',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(787,'Religion & Spirituality','Alternative Religions','IAB23-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(788,'Religion & Spirituality','Atheism/Agnosticism','IAB23-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(789,'Religion & Spirituality','Buddhism','IAB23-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(790,'Religion & Spirituality','Catholicism','IAB23-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(791,'Religion & Spirituality','Christianity','IAB23-5',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(792,'Religion & Spirituality','Hinduism','IAB23-6',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(793,'Religion & Spirituality','Islam','IAB23-7',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(794,'Religion & Spirituality','Judaism','IAB23-8',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(795,'Religion & Spirituality','Latter-Day Saints','IAB23-9',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(796,'Religion & Spirituality','Pagan/Wiccan','IAB23-10',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(797,'Uncategorized','Uncategorized','IAB24',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(798,'Non-Standard Content','Non-Standard Content','IAB25',1,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(799,'Non-Standard Content','Unmoderated UGC','IAB25-1',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(800,'Non-Standard Content','Extreme Graphic/Explicit Violence','IAB25-2',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(801,'Non-Standard Content','Pornography','IAB25-3',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(802,'Non-Standard Content','Profane Content','IAB25-4',0,'2016-10-20 20:31:34','2016-10-20 20:31:34'),(803,'Non-Standard Content','Hate Content','IAB25-5',0,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(804,'Non-Standard Content','Under Construction','IAB25-6',0,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(805,'Non-Standard Content','Incentivized','IAB25-7',0,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(806,'Illegal Content','Illegal Content','IAB26',1,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(807,'Illegal Content','Illegal Content','IAB26-1',0,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(808,'Illegal Content','Warez','IAB26-2',0,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(809,'Illegal Content','Spyware/Malware','IAB26-3',0,'2016-10-20 20:31:35','2016-10-20 20:31:35'),(810,'Illegal Content','Infringement','IAB26-4',0,'2016-10-20 20:31:35','2016-10-20 20:31:35');
/*!40000 ALTER TABLE `iab_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) DEFAULT NULL,
  `description` varchar(4096) DEFAULT NULL,
  `list_type` varchar(1024) DEFAULT NULL,
  `filesize` int(11) DEFAULT NULL,
  `s3_url` varchar(4096) DEFAULT NULL,
  `filepath` varchar(4096) DEFAULT NULL,
  `filetype` varchar(4096) DEFAULT NULL,
  `last_modified` varchar(1024) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lists`
--

LOCK TABLES `lists` WRITE;
/*!40000 ALTER TABLE `lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_commands`
--

DROP TABLE IF EXISTS `report_commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) DEFAULT NULL,
  `type` varchar(1024) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `description` varchar(2048) DEFAULT NULL,
  `command` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `banner_id` int(11) DEFAULT NULL,
  `banner_video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_commands`
--

LOCK TABLES `report_commands` WRITE;
/*!40000 ALTER TABLE `report_commands` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_commands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rtb_standards`
--

DROP TABLE IF EXISTS `rtb_standards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rtb_standards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rtbspecification` varchar(1024) DEFAULT NULL,
  `operator` varchar(1024) DEFAULT NULL,
  `operand` varchar(1024) DEFAULT NULL,
  `operand_type` varchar(16) DEFAULT NULL,
  `operand_ordinal` varchar(16) DEFAULT NULL,
  `rtb_required` tinyint(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `operand_list_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rtb_standards`
--

LOCK TABLES `rtb_standards` WRITE;
/*!40000 ALTER TABLE `rtb_standards` DISABLE KEYS */;
INSERT INTO `rtb_standards` VALUES (2,'request.app.bundle','','','','',1,'XXXX','','2017-04-13 21:21:53','2017-05-17 19:33:57',NULL),(4,'request.app.cat','EXISTS','','','',1,'AAAAA','','2017-04-21 23:47:42','2017-05-17 19:33:05',NULL);
/*!40000 ALTER TABLE `rtb_standards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20161016213949'),('20161016214838'),('20161016214953'),('20161016220000'),('20161016220010'),('20161016220020'),('20161018033520'),('20161020183701'),('20161020184506'),('20161020194248'),('20161020221420'),('20161020231935'),('20161021003044'),('20161021004915'),('20161021030353'),('20161024220835'),('20161024231508'),('20161029001818'),('20161029002517'),('20161029033648'),('20161029223604'),('20161030200804'),('20161031201345'),('20161031202535'),('20161031203023'),('20161101005351'),('20161101221306'),('20161101223050'),('20161101225756'),('20161101234124'),('20161102032928'),('20161102035328'),('20161111184549'),('20161125210101'),('20161125210914'),('20161126192553'),('20161201225124'),('20161205231515'),('20161208223652'),('20161209032930'),('20170111005550'),('20170315020331'),('20170315175706'),('20170315205723'),('20170420212849'),('20170425204354'),('20170426192339'),('20170501183107'),('20170503223845'),('20170503231704'),('20170511221000');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats_rtb`
--

DROP TABLE IF EXISTS `stats_rtb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats_rtb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` int(11) DEFAULT NULL,
  `stats_date` datetime DEFAULT NULL,
  `bids` int(11) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  `clicks` int(11) DEFAULT NULL,
  `pixels` int(11) DEFAULT NULL,
  `win_price` decimal(15,6) DEFAULT NULL,
  `bid_price` decimal(15,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats_rtb`
--

LOCK TABLES `stats_rtb` WRITE;
/*!40000 ALTER TABLE `stats_rtb` DISABLE KEYS */;
/*!40000 ALTER TABLE `stats_rtb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `targets`
--

DROP TABLE IF EXISTS `targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `targets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activate_time` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `list_of_domains` longtext COLLATE utf8mb4_polish_ci,
  `domain_targetting` varchar(50) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `geo_latitude` double DEFAULT NULL,
  `geo_longitude` double DEFAULT NULL,
  `geo_range` double DEFAULT NULL,
  `country` mediumtext COLLATE utf8mb4_polish_ci,
  `geo_region` mediumtext COLLATE utf8mb4_polish_ci,
  `carrier` mediumtext COLLATE utf8mb4_polish_ci,
  `os` mediumtext COLLATE utf8mb4_polish_ci,
  `make` mediumtext COLLATE utf8mb4_polish_ci,
  `model` mediumtext COLLATE utf8mb4_polish_ci,
  `devicetype` mediumtext COLLATE utf8mb4_polish_ci,
  `IAB_category` mediumtext COLLATE utf8mb4_polish_ci,
  `IAB_category_blklist` mediumtext COLLATE utf8mb4_polish_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `domains_list_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `targets`
--

LOCK TABLES `targets` WRITE;
/*!40000 ALTER TABLE `targets` DISABLE KEYS */;
INSERT INTO `targets` VALUES (1,'2018-01-01 00:00:00','2020-01-01 00:00:00','','',NULL,NULL,NULL,'USA','','','','','','','','','2016-10-22 01:30:06','2018-04-18 20:56:47','US Targets',NULL),(2,'2016-10-23 23:32:00','2017-04-29 23:32:00','','',26.863280626766237,77.5634765625,553191,'ALB','','','','','','3,1','IAB1-1,IAB1-3,IAB2-11','IAB2-6,IAB3-6','2016-10-23 23:33:16','2017-04-21 23:39:26','Target_2',NULL),(3,'2017-04-21 23:38:00','2017-04-22 23:38:00','','',NULL,NULL,NULL,'','','','','','','','','','2017-04-21 23:38:44','2017-04-21 23:38:44','XXXXX',NULL);
/*!40000 ALTER TABLE `targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_digest` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Peter Loh','ploh814@gmail.com','$2a$10$v.CqaFYl3CXuZRSX.Zfh0.G76d6Kg/iWKZ.vtxIvyIjV0NoggoNqq',1,'2016-10-24 23:42:55','2016-10-24 23:53:26'),(2,'Ben Faul','ben.faul@gmail.com','$2a$10$HuV.JIU9HqbzTj2P3F6T9OE/DXLT/nikSR3HLFpDosWhfBKTS87yi',1,'2016-10-25 21:46:24','2016-10-25 21:46:24'),(3,'Demo User','demo@rtb4free.com','$2a$10$IPU8M1bG3IEylaJWWeBu/u4DWTAgliEKb1kTeCGVU8LFsJCRahuYC',1,'2018-04-18 20:19:15','2018-04-18 20:19:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-18 21:33:19
