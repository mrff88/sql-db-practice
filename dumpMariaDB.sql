/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apostatadores` (
  `apostador_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `nro_documento_identidad` varchar(15) NOT NULL,
  PRIMARY KEY (`apostador_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `apostatadores` WRITE;
/*!40000 ALTER TABLE `apostatadores` DISABLE KEYS */;
INSERT INTO `apostatadores` VALUES (1,'Juan','Perez','12345678'),(2,'Marco','Cardenas','87654321');
/*!40000 ALTER TABLE `apostatadores` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apuestas` (
  `apostador_id` int(11) NOT NULL,
  `partido_id` int(11) NOT NULL,
  `bet_amount` double NOT NULL,
  `bet_date` datetime NOT NULL,
  PRIMARY KEY (`apostador_id`,`partido_id`),
  KEY `apuestas_FK_2` (`partido_id`),
  CONSTRAINT `apuestas_FK_1` FOREIGN KEY (`apostador_id`) REFERENCES `apostatadores` (`apostador_id`),
  CONSTRAINT `apuestas_FK_2` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`partido_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `apuestas` WRITE;
/*!40000 ALTER TABLE `apuestas` DISABLE KEYS */;
INSERT INTO `apuestas` VALUES (1,1,15,'2022-04-17 13:00:00'),(1,2,15,'2022-04-17 13:00:00'),(1,3,15,'2022-04-17 13:00:00'),(2,1,20,'2022-04-18 13:00:00'),(2,2,20,'2022-04-18 13:00:00'),(2,3,20,'2022-04-18 13:00:00');
/*!40000 ALTER TABLE `apuestas` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos` (
  `equipo_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `abbreviation` varchar(3) NOT NULL,
  PRIMARY KEY (`equipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,'Arsenal','ARS'),(2,'Manchester City','MNC'),(3,'Barcelona','BAR'),(4,'Real Madrid','RMD'),(5,'Inter Milan','INT'),(6,'Bayern Munich','MUN');
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ganador` (
  `ganador_id` int(11) NOT NULL AUTO_INCREMENT,
  `partido_id` int(11) NOT NULL,
  `equipo_ganador_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ganador_id`),
  KEY `ganador_FK` (`partido_id`),
  CONSTRAINT `ganador_FK` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`partido_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ganador` WRITE;
/*!40000 ALTER TABLE `ganador` DISABLE KEYS */;
INSERT INTO `ganador` VALUES (1,1,3,'Barcelona'),(2,2,4,'Real Madrid'),(3,3,5,'Inter Milan');
/*!40000 ALTER TABLE `ganador` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcador_apostado` (
  `marcador_apostado_id` int(11) NOT NULL AUTO_INCREMENT,
  `apostador_id` int(11) NOT NULL,
  `partido_id` int(11) NOT NULL,
  `first_equipo_score` int(11) NOT NULL,
  `second_equipo_score` int(11) NOT NULL,
  PRIMARY KEY (`marcador_apostado_id`),
  KEY `marcador_apostado_FK` (`apostador_id`,`partido_id`),
  CONSTRAINT `marcador_apostado_FK` FOREIGN KEY (`apostador_id`, `partido_id`) REFERENCES `apuestas` (`apostador_id`, `partido_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `marcador_apostado` WRITE;
/*!40000 ALTER TABLE `marcador_apostado` DISABLE KEYS */;
INSERT INTO `marcador_apostado` VALUES (1,1,1,1,3),(2,1,2,2,4),(3,1,3,0,1),(4,2,1,1,0),(5,2,2,0,1),(6,2,3,3,1);
/*!40000 ALTER TABLE `marcador_apostado` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcador_definitivo` (
  `marcador_definitivo_id` int(11) NOT NULL AUTO_INCREMENT,
  `partido_id` int(11) NOT NULL,
  `first_equipo_score` int(11) DEFAULT NULL,
  `second_equipo_score` int(11) DEFAULT NULL,
  PRIMARY KEY (`marcador_definitivo_id`),
  KEY `marcador_definitivo_FK` (`partido_id`),
  CONSTRAINT `marcador_definitivo_FK` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`partido_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `marcador_definitivo` WRITE;
/*!40000 ALTER TABLE `marcador_definitivo` DISABLE KEYS */;
INSERT INTO `marcador_definitivo` VALUES (1,1,1,3),(2,2,2,4),(3,3,3,1);
/*!40000 ALTER TABLE `marcador_definitivo` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partidos` (
  `partido_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_equipo_id` int(11) NOT NULL,
  `second_equipo_id` int(11) NOT NULL,
  `match_date` datetime NOT NULL,
  `state` tinyint(1) NOT NULL,
  PRIMARY KEY (`partido_id`),
  KEY `primer_equipo_FK` (`first_equipo_id`),
  KEY `segundo_equipo_FK` (`second_equipo_id`),
  CONSTRAINT `primer_equipo_FK` FOREIGN KEY (`first_equipo_id`) REFERENCES `equipos` (`equipo_id`),
  CONSTRAINT `segundo_equipo_FK` FOREIGN KEY (`second_equipo_id`) REFERENCES `equipos` (`equipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` VALUES (1,1,3,'2022-04-19 13:00:00',0),(2,2,4,'2022-04-20 13:00:00',0),(3,5,6,'2022-04-21 13:00:00',0);
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;
UNLOCK TABLES;
