-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: actividad15jhonatancabrera
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Hardware'),(2,'Software Hospitalario'),(3,'Red'),(4,'Impresoras'),(5,'Correo Institucional'),(6,'Base de Datos'),(7,'Equipos Biomédicos'),(8,'Sistema HIS');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especialidad` (
  `id_especialidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (1,'Hardware'),(2,'Software Hospitalario'),(3,'Redes'),(4,'Base de Datos'),(5,'Seguridad Informática'),(6,'Equipos Biomédicos');
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id_estado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'Pendiente'),(2,'Asignada'),(3,'En Proceso'),(4,'Resuelta');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidencia`
--

DROP TABLE IF EXISTS `incidencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencia` (
  `id_incidencia` int(11) NOT NULL AUTO_INCREMENT,
  `ticket` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `descripcion` text NOT NULL,
  `equipo` varchar(80) NOT NULL,
  `sistema_operativo` varchar(80) NOT NULL,
  `ubicacion` varchar(120) NOT NULL,
  `categoria_ia` varchar(50) NOT NULL,
  `prioridad` varchar(10) NOT NULL,
  `solucion_ia` text NOT NULL,
  `solucion_final` text NOT NULL,
  `fecha_cierre` datetime NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tecnico_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  PRIMARY KEY (`id_incidencia`),
  KEY `usuario_id` (`usuario_id`),
  KEY `tecnico_id` (`tecnico_id`),
  KEY `categoria_id` (`categoria_id`),
  KEY `estado_id` (`estado_id`),
  CONSTRAINT `incidencia_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id_estado`),
  CONSTRAINT `incidencia_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidencia_ibfk_3` FOREIGN KEY (`tecnico_id`) REFERENCES `tecnico` (`id_tecnico`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incidencia_ibfk_4` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidencia`
--

LOCK TABLES `incidencia` WRITE;
/*!40000 ALTER TABLE `incidencia` DISABLE KEYS */;
INSERT INTO `incidencia` VALUES (1,'HSP-0001','2026-07-20','08:15:00','El sistema HIS no inicia','El sistema hospitalario no permite iniciar sesión.','PC-EME-01','Windows 11','Emergencias','Sistema HIS','Alta','Verificar servicio del servidor HIS.','Se reinició el servicio y el acceso quedó habilitado.','2026-07-27 09:00:00',1,2,8,4),(2,'HSP-0002','2026-07-27','08:40:00','Impresora de laboratorio sin conexión','No imprime resultados de laboratorio.','IMP-LAB-01','Firmware','Laboratorio','Impresoras','Media','Revisar conexión USB y cola de impresión.','','0000-00-00 00:00:00',3,1,4,1),(3,'HSP-0003','2026-07-27','09:20:00','Sin acceso a Internet','No existe conexión a Internet en Consulta Externa.','PC-CON-04','Windows 10','Consulta Externa','Red','Alta','Verificar switch y cableado.','','0000-00-00 00:00:00',2,3,3,3),(4,'HSP-0004','2026-07-27','10:00:00','Error en base de datos','El HIS muestra error de conexión con MySQL.','SRV-01','Ubuntu Server','Centro de Datos','Base de Datos','Crítica','Comprobar servicio MySQL.','','0000-00-00 00:00:00',2,4,6,2),(5,'HSP-0005','2026-07-27','10:30:00','Monitor del ECG sin imagen','El monitor cardíaco no muestra datos.','ECG-05','Sistema Embebido','UCI','Equipos Biomédicos','Crítica','Verificar alimentación y cable HDMI.','','0000-00-00 00:00:00',1,5,7,3),(6,'HSP-0006','2026-07-27','11:10:00','No funciona el correo institucional','No se reciben correos médicos.','PC-ADM-03','Windows 11','Dirección','Correo Institucional','Media','Comprobar configuración IMAP.','','0000-00-00 00:00:00',5,2,5,2),(7,'HSP-0007','2026-07-27','12:00:00','Computadora muy lenta','Equipo tarda demasiado en iniciar.','PC-FAR-01','Windows 10','Farmacia','Hardware','Media','Liberar espacio y revisar disco.','','0000-00-00 00:00:00',4,1,1,1),(8,'HSP-0008','2026-07-27','13:40:00','No imprime recetas','La impresora no responde desde el sistema.','IMP-FAR-02','Firmware','Farmacia','Impresoras','Alta','Reinstalar controlador.','','0000-00-00 00:00:00',4,1,4,2),(9,'HSP-0009','2026-07-27','14:15:00','Error al registrar pacientes','El módulo de admisión presenta excepción.','PC-ADM-01','Windows 11','Admisión','Software Hospitalario','Alta','Revisar registros del sistema.','','0000-00-00 00:00:00',5,2,2,3),(10,'HSP-0010','2026-07-27','15:20:00','Equipo de Rayos X sin comunicación','La estación de trabajo perdió comunicación con el equipo.','RX-01','Windows 11','Radiología','Equipos Biomédicos','Crítica','Verificar red y software del fabricante.','','0000-00-00 00:00:00',6,5,7,1);
/*!40000 ALTER TABLE `incidencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `rol` varchar(100) NOT NULL,
  `tecnico_id` int(11) NOT NULL,
  PRIMARY KEY (`id_login`),
  KEY `tecnico_id` (`tecnico_id`),
  CONSTRAINT `login_ibfk_1` FOREIGN KEY (`tecnico_id`) REFERENCES `tecnico` (`id_tecnico`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'admin','123456','Administrador',1),(2,'cmendoza','123456','Tecnico',1),(3,'mgutierrez','123456','Tecnico',2),(4,'lfernandez','123456','Tecnico',3),(5,'psuarez','123456','Tecnico',4),(6,'jrivera','123456','Tecnico',5);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `reporte_incidencias`
--

DROP TABLE IF EXISTS `reporte_incidencias`;
/*!50001 DROP VIEW IF EXISTS `reporte_incidencias`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `reporte_incidencias` AS SELECT
 1 AS `ticket`,
  1 AS `fecha`,
  1 AS `hora`,
  1 AS `titulo`,
  1 AS `prioridad`,
  1 AS `usuario`,
  1 AS `tecnico`,
  1 AS `categoria`,
  1 AS `estado` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tecnico`
--

DROP TABLE IF EXISTS `tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tecnico` (
  `id_tecnico` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `especialidad_id` int(11) NOT NULL,
  PRIMARY KEY (`id_tecnico`),
  KEY `especialidad_id` (`especialidad_id`),
  CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidad` (`id_especialidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnico`
--

LOCK TABLES `tecnico` WRITE;
/*!40000 ALTER TABLE `tecnico` DISABLE KEYS */;
INSERT INTO `tecnico` VALUES (1,'Carlos','Mendoza','cmendoza@hospital.bo',76543210,1),(2,'María','Gutiérrez','mgutierrez@hospital.bo',76543211,2),(3,'Luis','Fernández','lfernandez@hospital.bo',76543212,3),(4,'Patricia','Suárez','psuarez@hospital.bo',76543213,4),(5,'Jorge','Rivera','jrivera@hospital.bo',76543214,6);
/*!40000 ALTER TABLE `tecnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(60) NOT NULL,
  `apellidos` varchar(60) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `cargo` varchar(80) NOT NULL,
  `area` varchar(80) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Ana','Rojas','ana.rojas@hospital.bo',70000001,'Enfermera','Emergencias'),(2,'Miguel','Pérez','miguel.perez@hospital.bo',70000002,'Médico','Consulta Externa'),(3,'Sandra','Flores','sandra.flores@hospital.bo',70000003,'Bioquímica','Laboratorio'),(4,'Diego','Vargas','diego.vargas@hospital.bo',70000004,'Farmacéutico','Farmacia'),(5,'Carla','Mamani','carla.mamani@hospital.bo',70000005,'Recepcionista','Admisión'),(6,'José','López','jose.lopez@hospital.bo',70000006,'Técnico','Radiología');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `reporte_incidencias`
--

/*!50001 DROP VIEW IF EXISTS `reporte_incidencias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reporte_incidencias` AS select `i`.`ticket` AS `ticket`,`i`.`fecha` AS `fecha`,`i`.`hora` AS `hora`,`i`.`titulo` AS `titulo`,`i`.`prioridad` AS `prioridad`,concat(`u`.`nombres`,' ',`u`.`apellidos`) AS `usuario`,concat(`t`.`nombres`,' ',`t`.`apellidos`) AS `tecnico`,`c`.`nombre` AS `categoria`,`e`.`nombre` AS `estado` from ((((`incidencia` `i` join `usuario` `u` on(`i`.`usuario_id` = `u`.`id_usuario`)) left join `tecnico` `t` on(`i`.`tecnico_id` = `t`.`id_tecnico`)) join `categoria` `c` on(`i`.`categoria_id` = `c`.`id_categoria`)) join `estado` `e` on(`i`.`estado_id` = `e`.`id_estado`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-30  6:01:46
