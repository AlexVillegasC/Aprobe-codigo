
CREATE DATABASE APROBE;
USE APROBE;


CREATE TABLE grupoMinoritario(
	idGrupoMinoritario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nomGrupoMinoritario VARCHAR(20) NOT NULL 
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE `estudiantes` (
  `cedula` VARCHAR(20) NOT NULL,
  `fecha_nac` DATETIME NOT NULL,
  `fecha_expedicion` DATETIME DEFAULT NULL,
  `nomDialecto` VARCHAR(40) DEFAULT NULL,
  `numNivel` INT(11) DEFAULT NULL,
  `idGrupoMinoritario` INT(11) DEFAULT NULL,
  PRIMARY KEY (`cedula`),
  KEY `estudiantes_ibfk_1` (`idGrupoMinoritario`),
  CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`idGrupoMinoritario`) REFERENCES `grupominoritario` (`idGrupoMinoritario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE estadoConyugal(
	nomEstado VARCHAR(15) NOT NULL,
	idEsdato INT (2) NOT NULL,
	PRIMARY KEY (`idEsdato`)
)ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE GrupoFamiliar(
	idFamilia INT AUTO_INCREMENT NOT NULL,
	telefono INT(11) DEFAULT NULL,
	email VARCHAR(50) DEFAULT NULL,
	codDireccion INT(9) DEFAULT NULL,
	cedEstudiante VARCHAR(20) NOT NULL,
	idEstadoConyugal INT (2) DEFAULT NULL,
	PRIMARY KEY(`idFamilia`),
	KEY `grupoFamiliar_est_FK` (`cedEstudiante`),
	KEY `grupoFamiliar_cony_FK` (`idEstadoConyugal`),
	CONSTRAINT `grupoFamiliar_est_FK` FOREIGN KEY (cedEstudiante) REFERENCES Estudiantes(`cedula`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `grupoFamiliar_cony_FK` FOREIGN KEY (idEstadoConyugal) REFERENCES estadoConyugal(idEsdato) ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE Encargados(
	cedula VARCHAR(20) NOT NULL,
	nacionalidad VARCHAR(30) NOT NULL,
	fechaExpedicion DATETIME DEFAULT NULL,
	fechaVencimiento DATETIME DEFAULT NULL,
	cedEstudiante VARCHAR(20) NOT NULL,
	PRIMARY KEY(cedula),
	KEY `Èncargados_est_FK`(cedEstudiante),
	FOREIGN KEY(`cedEstudiante`) REFERENCES Estudiantes(`cedula`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE EstadoSolicitud(
        nomEstado VARCHAR(10) NOT NULL,
        codEstado CHAR (1) NOT NULL,
        PRIMARY KEY(codEstado)
                
)ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE SolicitudEstudiante(
	cedula VARCHAR(20) NOT NULL,	
	fechaSolicitud DATETIME NOT NULL,
	estadoSolicitud CHAR(1) NOT NULL,
	tipoBeca INT(1) NOT NULL,
	PRIMARY KEY (cedula),
	KEY `solcilicitud_estado_FK` (cedula),
	KEY `solicitud_estado_FK` (estadoSolicitud),
	CONSTRAINT `solcilicitud_estado_FK` FOREIGN KEY (cedula) REFERENCES estudiantes(cedula) ON DELETE  CASCADE ON UPDATE CASCADE,
        CONSTRAINT `solicitud_estado_FK` FOREIGN KEY (estadoSolicitud) REFERENCES estadoSolicitud (codEstado) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE estudianteSituacionEsp(
        cedEstudiante VARCHAR(20) NOT NULL,	
	situacionEspecial  VARCHAR(680) NOT NULL,
	PRIMARY KEY (cedEstudiante),
	KEY `situacionEsp_est` (cedEstudiante),
	CONSTRAINT `situacionEsp_est` FOREIGN KEY (cedEstudiante) REFERENCES SolicitudEstudiante(cedula) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


-- seccion rutas
CREATE TABLE EmpresaTransp(
         codTransporte INT(11) NOT NULL ,
         nomTransportista VARCHAR (30) NOT NULL,
         PRIMARY KEY (codTransporte)
)ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE Recorrido(
	  codRecorrido varchar(500) NOT NULL,
	  nombre VARCHAR(20) NULL,	
	  PRIMARY KEY (codRecorrido)
	)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE ruta(
   codRuta INT(11) NOT NULL,
   codTransporte INT(11) NOT NULL, 
   codRecorrido INT (11) NOT NULL,
    PRIMARY KEY (codRuta),
    KEY `ruta_trasp_fk` (codTransporte),
    KEY `ruta_recorrido_fk` (codRecorrido),
   CONSTRAINT `ruta_trasp_fk` FOREIGN KEY (codTransporte) REFERENCES EmpresaTransp(codTransporte) ON DELETE CASCADE ON UPDATE CASCADE,
   FOREIGN KEY `ruta_recorrido_fk`(codRecorrido) REFERENCES Recorrido(codRecorrido) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;



CREATE TABLE RutaEstudiante(
    cedula VARCHAR (20) NOT NULL,
    codRuta INT (11) NOT NULL,
    KEY `ruta_est_fk` (cedula),
    KEY `ruta_cod_fk` (codRuta),
    CONSTRAINT `ruta_est_fk`FOREIGN KEY (cedula) REFERENCES Estudiantes(cedula) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `ruta_cod_fk` FOREIGN KEY `ruta_cod_fk`(codRuta) REFERENCES ruta(codRuta) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE condicion(
      idCondicion INT (1) NOT NULL ,
      nomCondicion VARCHAR (20) NOT NULL,
      PRIMARY KEY(idCondicion) 
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE condicionSE(
		 idFamilia INT NOT NULL ,
		 percapita DOUBLE NOT NULL,
		 totalIngresos DOUBLE NOT NULL,
		 idCondicion INT (1) NOT NULL,
		 PRIMARY KEY (idFamilia),
		 KEY `condicionSE_familia_FK` (idFamilia),
		 KEY `condicionSE_condi_FK` (`idCondicion`),
		 FOREIGN KEY (`idFamilia`) REFERENCES `Grupofamiliar`(`idFamilia`) ON DELETE CASCADE ON UPDATE CASCADE,
		 FOREIGN KEY (`idCondicion`) REFERENCES condicion(`idCondicion`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE accesoCentroEducativo(
	idFamilia INT  NOT NULL,
	distanciaKmResidenciaColegio FLOAT NOT NULL,
	distanciaKmResidenciaHogar FLOAT NOT NULL, 
	distanciaKmHogarColegio FLOAT NOT NULL,
	transPublico  BOOLEAN NOT NULL,
	cercaniaOtroCole  BOOLEAN NOT NULL,
	PRIMARY KEY (idFamilia),
	KEY `accesoCentro_FK` (idFamilia),
	CONSTRAINT `accesoCentro_FK` FOREIGN KEY (`idFamilia`) REFERENCES `grupofamiliar`(`idFamilia`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE EstudianteCercaniaOtroCole(
	nombre VARCHAR(20) NOT NULL, 
	distanciaKmOtroColegioHogar FLOAT NOT NULL,
	motivoNoMatricula VARCHAR(500) NOT NULL,
	idFamilia INT  NOT NULL,
	PRIMARY KEY (idFamilia),
	KEY `EstdianteCercaniaOtroCole`(idFamilia),
	CONSTRAINT `EstdianteCercaniaOtroCole` FOREIGN KEY (`idFamilia`) REFERENCES `accesoCentroEducativo`(`idFamilia`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;





CREATE TABLE medioTransporte(
	nombre VARCHAR(20) NOT NULL,
	costoDiario FLOAT NOT NULL,
	explicacionMedioTrans VARCHAR(500) DEFAULT NULL,
	idFamilia INT  NOT NULL,
	PRIMARY KEY (idFamilia),
	KEY `medioTran_fam_FK` (idFamilia),
	CONSTRAINT `medioTran_fam_FK` FOREIGN KEY (`idFamilia`) REFERENCES `accesoCentroEducativo`(`idFamilia`)
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE otrosIngresos(
	nombre VARCHAR(40) NOT NULL,
	idIngresos CHAR(4) NOT NULL PRIMARY KEY
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE ingresosGrupoFamiliar(
	idFamilia INT NOT NULL,
	idIngresos CHAR(4) NOT NULL,
	montoMen DOUBLE NOT NULL,	
	 PRIMARY KEY(idIngresos),
	 KEY `ingrosoG_F`(idFamilia),
	 KEY `ingresoG_Otros`(idIngresos),
	CONSTRAINT `ingrosoG_F` FOREIGN KEY(`idFamilia`) REFERENCES grupofamiliar(`idFamilia`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT  `ingresoG_Otros` FOREIGN KEY(`idIngresos`) REFERENCES otrosIngresos(`idIngresos`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE  nacionalidad(
	codNacionalidad INT(11) NOT NULL PRIMARY KEY,
	nomNacionalidad VARCHAR(100) NOT NULL
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE parentesco(
        idParentesco INT (2) NOT NULL PRIMARY KEY,
        nomParentesco VARCHAR (15) NOT NULL
)ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE escolaridad(
        idEscolaridad INT (2) NOT NULL PRIMARY KEY,
        nomEscolaridad VARCHAR (35) NOT NULL
)ENGINE=INNODB DEFAULT CHARSET=latin1;


-- DEBE LLARMARSE  PERSONA
CREATE TABLE MiembrosFamilia(
		cedula VARCHAR(20) NOT NULL ,	
		nombre VARCHAR(40) NOT NULL,
		primerApellido VARCHAR(40) NOT NULL,
		segundoApellido VARCHAR(40) NOT NULL,
		codNacionalidad INT(11) NOT NULL,
		edad INT(2) null, -- NOT NULL,
		idParentesco INT(2) null, -- NOT NULL,
		becas  BOOLEAN DEFAULT NULL,
		idEscolaridad INT(2) null, -- NOT NULL,
		sexo INT(11) DEFAULT NULL,
		PRIMARY KEY (cedula),
		KEY `miembFam_nacionalidad_FK` (codNacionalidad),
		KEY `miembFam_Parentesco_FK` (idParentesco),
		KEY `miembFam_Escolaridad_FK` (idEscolaridad),
		CONSTRAINT `miembFam_nacionalidad_FK` FOREIGN KEY(`codNacionalidad`) REFERENCES nacionalidad(`codNacionalidad`)  ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT `miembFam_Parentesco_FK` FOREIGN KEY(`idParentesco`) REFERENCES parentesco(`idParentesco`)  ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT `miembFam_Escolaridad_FK` FOREIGN KEY(`idEscolaridad`) REFERENCES escolaridad(`idEscolaridad`)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;

CREATE TABLE becasMiembro(
	nombre VARCHAR(40) NOT NULL,
	montoMen DOUBLE NOT NULL,
	cedula VARCHAR(20) NOT NULL ,	
	explicacion VARCHAR(500),
	PRIMARY KEY (cedula),
	KEY `becasMiemb_mieb_FK` (cedula),
	CONSTRAINT `becasMiemb_mieb_FK` FOREIGN KEY(`cedula`) REFERENCES MiembrosFamilia(`cedula`) ON DELETE CASCADE ON UPDATE CASCADE
	
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE ingresosOcupacion(
		cedula VARCHAR(20) NOT NULL,
		ocupacion VARCHAR(15) NOT NULL,
		ingresoMen DOUBLE NOT NULL,
		PRIMARY KEY(cedula),
		KEY `ingresOcu_miemb_FK`(cedula),
		CONSTRAINT `ingresOcu_miemb_FK` FOREIGN KEY (`cedula`) REFERENCES `MiembrosFamilia`(`cedula`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE GrupoFamiliarMiembros(
		 idFamilia INT NOT NULL ,
		 cedulaMiembro VARCHAR(20) NOT NULL,
		 KEY `grupoF_iemb_fk`(idFamilia),
		 KEY `grupoF_miembro_FK` (cedulaMiembro),
		 CONSTRAINT `grupoF_iemb_fk` FOREIGN KEY (`idFamilia`) REFERENCES `Grupofamiliar`(`idFamilia`)  ON DELETE CASCADE ON UPDATE CASCADE,
		 CONSTRAINT `grupoF_miembro_FK` FOREIGN KEY (`cedulaMiembro`) REFERENCES `MiembrosFamilia`(`cedula`)  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=INNODB DEFAULT CHARSET=latin1; 



CREATE TABLE logAdmin(
	cedula VARCHAR(20) NOT NULL PRIMARY KEY,
	clave VARCHAR(200) NOT NULL
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE logEstudiante(
	cedula VARCHAR(20) NOT NULL PRIMARY KEY,
	clave VARCHAR(200) NOT NULL
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE logComiteBecas(
	cedula VARCHAR(20) NOT NULL PRIMARY KEY,
	clave VARCHAR(200) NOT NULL
)ENGINE=INNODB DEFAULT CHARSET=latin1;

	
DROP TABLE IF EXISTS Bitacora;	
CREATE TABLE Bitacora(
	codigo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	fecha DATETIME NOT NULL,
	usuarioRealiza VARCHAR(25) NOT NULL,
	cedulaUsuarioRealiza VARCHAR(20) NOT NULL,
	justificacion VARCHAR(200) NULL
	
)ENGINE=INNODB DEFAULT CHARSET=latin1;


CREATE TABLE Provincia(
		nombre  VARCHAR(20) NOT NULL,
		codProvincia  INT(11) NOT NULL PRIMARY KEY
	)ENGINE=INNODB DEFAULT CHARSET=latin1;
	
	CREATE TABLE Canton(
		nombre VARCHAR(30) NOT NULL,
		codCanton INT(11) NOT NULL PRIMARY KEY ,
		codProvincia INT(11) NOT NULL,
		FOREIGN KEY (`codProvincia`) REFERENCES Provincia (`codProvincia`)
	)ENGINE=INNODB DEFAULT CHARSET=latin1;

	
	 CREATE TABLE Distrito(
		nombre VARCHAR(30) NOT NULL,
		codDistrito INT (11) NOT NULL PRIMARY KEY,
		codCanton INT(11) NOT NULL,
		FOREIGN KEY (`codCanton`) REFERENCES Canton (`codCanton`)
	   )ENGINE=INNODB DEFAULT CHARSET=latin1;

	CREATE TABLE Cacerio(
		nombre VARCHAR(30) NOT NULL,
		codCacerio INT(11) NOT NULL PRIMARY KEY,
		codDistrito INT(11) NOT NULL,
		FOREIGN KEY (`codDistrito`) REFERENCES `Distrito`(`codDistrito`)
	  )ENGINE=INNODB DEFAULT CHARSET=latin1;
  
  -- DEBE LLAMARSE  PERFILES
	DROP TABLE IF EXISTS TipoUsuario;
	CREATE TABLE TipoUsuario(
		IDUsuario INT AUTO_INCREMENT NOT NULL  PRIMARY KEY,
		Nombre VARCHAR(20)  
	)ENGINE=INNODB DEFAULT CHARSET=latin1; 

	DROP TABLE IF EXISTS  TipoUsuario_Miembro;
	CREATE TABLE TipoUsuario_Miembro(
		IDUsuario INT NOT NULL,
		Ced VARCHAR(20) NOT NULL primary key,
		KEY `TipoUsuario_MiembroFK`(`IDUsuario`),
		KEY `Miembro_TipoUsuarioFK`(`Ced`),
		CONSTRAINT `TipoUsuario_MiembroFK`  FOREIGN KEY(`IDUsuario`) REFERENCES `TipoUsuario`(`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT `Miembro_TipoUsuarioFK`  FOREIGN KEY(`Ced`) REFERENCES `MiembrosFamilia`(`cedula`) ON DELETE CASCADE ON UPDATE CASCADE
	)ENGINE=INNODB DEFAULT CHARSET=latin1; 
	 

/*Data*/



/*Data for the table `tnacionalidad` */
INSERT  INTO `nacionalidad`(`codNacionalidad`,`nomNacionalidad`) VALUES (1,'Costa Rica'),(2,'Canadá'),(3,'Estados Unidos'),(4,'México'),(5,'Belice'),(6,'Guatemala'),(7,'Honduras'),(8,'El Salvador'),(9,'Nicaragua'),(10,'Panamá'),(11,'Cuba'),(12,'Haití'),(13,'República Dominicana'),(14,'Otras Islas del Caribe'),(15,'Colombia'),(16,'Ecuador'),(17,'Perú'),(18,'Bolivia'),(19,'Chile'),(20,'Argentina'),(21,'Paraguay'),(22,'Uruguay'),(23,'Brasil'),(24,'Venezuela'),(25,'Guyana'),(26,'Europa'),(27,'Africa'),(28,'Asia'),(29,'Oceanía');

/*Data for the table `tprovincia` */
-- INSERT  INTO `provincia`(`codProvincia`,`nombre`) VALUES (1,'San José'),(2,'Alajuela'),(3,'Cartago'),(4,'Heredia'),(5,'Guanacaste'),(6,'Puntarenas'),(7,'Limón');

/*Data for the table `tcanton` */
-- INSERT  INTO `Canton`(`codCanton`,`nombre`,`codProvincia`) VALUES (101,'San José',1),(102,'Escazú',1),(103,'Desamparados',1),(104,'Puriscal',1),(105,'Tarrazú',1),(106,'Aserrí',1),(107,'Mora',1),(108,'Goicoechea',1),(109,'Santa Ana',1),(110,'Alajuelita',1),(111,'Vázquez de Coronado',1),(112,'Acosta',1),(113,'Tibás',1),(114,'Moravia',1),(115,'Montes de Oca',1),(116,'Turrubares',1),(117,'Dota',1),(118,'Curridabat',1),(119,'Pérez Zeledón',1),(120,'León Cortes',1),(201,'Alajuela',2),(202,'San Ramón',2),(203,'Grecia',2),(204,'San Mateo',2),(205,'Atenas',2),(206,'Naranjo',2),(207,'Palmares',2),(208,'Poás',2),(209,'Orotina',2),(210,'San Carlos',2),(211,'Alfaro Ruíz',2),(212,'Valverde Vega',2),(213,'Upala',2),(214,'Los Chiles',2),(215,'Guatuso',2),(301,'Cartago',3),(302,'Paraíso',3),(303,'La Unión',3),(304,'Jiménez',3),(305,'Turrialba',3),(306,'Alvarado',3),(307,'Oreamuno',3),(308,'Guarco',3),(401,'Heredia',4),(402,'Barba',4),(403,'Santo Domingo',4),(404,'Santa Bárbara',4),(405,'San Rafael',4),(406,'San Isidro',4),(407,'Belén',4),(408,'Flores',4),(409,'San Pablo',4),(410,'Sarapiquí',4),(501,'Liberia',5),(502,'Nicoya',5),(503,'Santa Cruz',5),(504,'Bagaces',5),(505,'Carrillo',5),(506,'Cañas',5),(507,'Abangares',5),(508,'Tilarán',5),(509,'Nandayure',5),(510,'La Cruz',5),(511,'Hojancha',5),(601,'Puntarenas',6),(602,'Esparza',6),(603,'Buenos Aires',6),(604,'Montes de Oro',6),(605,'Osa',6),(606,'Aguirre',6),(607,'Golfito',6),(608,'Coto Brus',6),(609,'Parrita',6),(610,'Corredores',6),(611,'Garabito',6),(701,'Limón',7),(702,'Pococí',7),(703,'Siquirres',7),(704,'Talamanca',7),(705,'Matina',7),(706,'Guácimo',7);

INSERT  INTO `Canton`(`codCanton`,`nombre`,`codProvincia`) 
VALUES (509,'Nandayure',5);

/*Data for the table `tdistrito` */
-- INSERT  INTO `distrito`(`codDistrito`,`nombre`,`codCanton`) VALUES (10101,'Carmen',101),(10102,'Merced',101),(10103,'Hospital',101),(10104,'Catedral',101),(10105,'Zapote',101),(10106,'San Francisco de Dos Ríos',101),(10107,'Uruca',101),(10108,'Mata Redonda',101),(10109,'Pavas',101),(10110,'Hatillo',101),(10111,'San Sebastián',101),(10201,'Escazú',102),(10202,'San Antonio',102),(10203,'San Rafael',102),(10301,'Desamparados',103),(10302,'San Miguel',103),(10303,'San Juan de Dios',103),(10304,'San Rafael',103),(10305,'San Antonio',103),(10306,'Frailes',103),(10307,'Patarrá',103),(10308,'San Cristóbal',103),(10309,'Rosario',103),(10310,'Damas',103),(10311,'San Rafael Abajo',103),(10312,'Gravilias',103),(10401,'Santiago',104),(10402,'Mercedes Sur',104),(10403,'Barbacoas',104),(10404,'Grifo Alto',104),(10405,'San Rafael',104),(10406,'Candelarita',104),(10407,'Desamparaditos',104),(10408,'San Antonio',104),(10409,'Chires',104),(10501,'San Marcos',105),(10502,'San Lorenzo',105),(10503,'San Carlos',105),(10601,'Aserrí',106),(10602,'Tarbaca',106),(10603,'Vuelta de Jorco',106),(10604,'San Gabriel',106),(10605,'Legua',106),(10606,'Monterrey',106),(10607,'Salitrillos',106),(10701,'Colón',107),(10702,'Guayabo',107),(10703,'Tabarcia',107),(10704,'Piedras Negras',107),(10705,'Picagres',107),(10801,'Guadalupe',108),(10802,'San Francisco',108),(10803,'Calle Blancos',108),(10804,'Mata de Plátano',108),(10805,'Ipís',108),(10806,'Rancho Redondo',108),(10807,'Purral',108),(10901,'Santa Ana',109),(10902,'Salitral',109),(10903,'Pozos',109),(10904,'Uruca',109),(10905,'Piedades',109),(10906,'Brasil',109),(11001,'Alajuelita',110),(11002,'San Josecito',110),(11003,'San Antonio',110),(11004,'Concepción',110),(11005,'San Felipe',110),(11101,'San Isidro',111),(11102,'San Rafael',111),(11103,'Jesús (Dulce Nombre)',111),(11104,'Patalillo',111),(11105,'Cascajal',111),(11201,'San Ignacio',112),(11202,'Guaitil',112),(11203,'Palmichal',112),(11204,'Cangrejal',112),(11205,'Sabanillas',112),(11301,'San Juan',113),(11302,'Cinco Esquinas',113),(11303,'Anselmo Llorente',113),(11304,'León XIII',113),(11305,'Colima',113),(11401,'San Vicente',114),(11402,'San Jerónimo',114),(11403,'Trinidad',114),(11501,'San Pedro',115),(11502,'Sabanilla',115),(11503,'Mercedes (Betania)',115),(11504,'San Rafael',115),(11601,'San Pablo',116),(11602,'San Pedro',116),(11603,'San Juan de Mata',116),(11604,'San Luis',116),(11701,'Santa María',117),(11702,'Jardín',117),(11703,'Copey',117),(11801,'Curridabat',118),(11802,'Granadilla',118),(11803,'Sánchez',118),(11804,'Tirrases',118),(11901,'San Isidro de El General',119),(11902,'General',119),(11903,'Daniel Flores',119),(11904,'Rivas',119),(11905,'San Pedro',119),(11906,'Platanares',119),(11907,'Pejibaye',119),(11908,'Cajón',119),(11909,'Barú',119),(11910,'Río Nuevo',119),(11911,'El Páramo',119),(12001,'San Pablo',120),(12002,'San Andrés',120),(12003,'Llano Bonito',120),(12004,'San Isidro',120),(12005,'Santa Cruz',120),(12006,'San Antonio',120),(20101,'Alajuela',201),(20102,'San José',201),(20103,'Carrizal',201),(20104,'San Antonio',201),(20105,'Guácima',201),(20106,'San Isidro',201),(20107,'Sabanilla',201),(20108,'San Rafael',201),(20109,'Río Segundo',201),(20110,'Desamparados',201),(20111,'Turrúcares',201),(20112,'Tambor',201),(20113,'Garita',201),(20114,'Sarapiquí',201),(20201,'San Ramón',202),(20202,'Santiago',202),(20203,'San Juan',202),(20204,'Piedades Norte',202),(20205,'Piedades Sur',202),(20206,'San Rafael',202),(20207,'San Isidro',202),(20208,'Ángeles',202),(20209,'Alfaro',202),(20210,'Volio',202),(20211,'Concepción',202),(20212,'Zapotal',202),(20213,'Peñas Blancas',202),(20301,'Grecia',203),(20302,'San Isidro',203),(20303,'San José',203),(20304,'San Roque',203),(20305,'Tacares',203),(20306,'Río Cuarto',203),(20307,'Puente de Piedra',203),(20308,'Bolívar',203),(20401,'San Mateo',204),(20402,'Desmonte',204),(20403,'Jesús María',204),(20501,'Atenas',205),(20502,'Jesús',205),(20503,'Mercedes',205),(20504,'San Isidro',205),(20505,'Concepción',205),(20506,'San José',205),(20507,'Santa Eulalia',205),(20601,'Naranjo',206),(20602,'San Miguel',206),(20603,'San José',206),(20604,'Cirrí Sur',206),(20605,'San Jerónimo',206),(20606,'San Juan',206),(20607,'Rosario',206),(20701,'Palmares',207),(20702,'Zaragoza',207),(20703,'Buenos Aires',207),(20704,'Santiago',207),(20705,'Candelaria',207),(20706,'Esquipulas',207),(20707,'Granja',207),(20801,'San Pedro',208),(20802,'San Juan',208),(20803,'San Rafael',208),(20804,'Carrillos',208),(20805,'Sabana Redonda',208),(20901,'Orotina',209),(20902,'Mastate',209),(20903,'Hacienda Vieja',209),(20904,'Coyolar',209),(20905,'Ceiba',209),(21001,'Quesada',210),(21002,'Florencia',210),(21003,'Buenavista',210),(21004,'Aguas Zarcas',210),(21005,'Venecia',210),(21006,'Pital',210),(21007,'Fortuna',210),(21008,'Tigra',210),(21009,'Palmera',210),(21010,'Venado',210),(21011,'Cutris',210),(21012,'Monterrey',210),(21013,'Pocosol',210),(21101,'Zarcero',211),(21102,'Laguna',211),(21103,'Tapezco',211),(21104,'Guadalupe',211),(21105,'Palmira',211),(21106,'Zapote',211),(21107,'Brisas',211),(21201,'Sarchí Norte',212),(21202,'Sarchí Sur',212),(21203,'Toro Amarillo',212),(21204,'San Pedro',212),(21205,'Rodríguez',212),(21301,'Upala',213),(21302,'Aguas Claras',213),(21303,'San José (Pizote)',213),(21304,'Bijagua',213),(21305,'Delicias',213),(21306,'Dos Ríos (Colonia Mayorga)',213),(21307,'Yolillal',213),(21401,'Los Chiles',214),(21402,'Caño Negro',214),(21403,'El Amparo',214),(21404,'San Jorge',214),(21501,'San Rafael',215),(21502,'Buenavista',215),(21503,'Cote',215),(30101,'Oriental',301),(30102,'Occidental',301),(30103,'Carmen',301),(30104,'San Nicolás',301),(30105,'San Francisco',301),(30106,'Guadalupe',301),(30107,'Corralillo',301),(30108,'Tierra Blanca',301),(30109,'Dulce Nombre',301),(30110,'Llano Grande',301),(30111,'Quebradilla',301),(30201,'Paraíso',302),(30202,'Santiago',302),(30203,'Orosi',302),(30204,'Cachí',302),(30301,'Tres Ríos',303),(30302,'San Diego',303),(30303,'San Juan',303),(30304,'San Rafael',303),(30305,'Concepción',303),(30306,'Dulce Nombre',303),(30307,'San Ramón',303),(30308,'Río Azul',303),(30401,'Juan Viñas',304),(30402,'Tucurrique',304),(30403,'Pejibaye',304),(30501,'Turrialba',305),(30502,'La Suiza',305),(30503,'Peralta',305),(30504,'Santa Cruz',305),(30505,'Santa Teresita',305),(30506,'Pavones',305),(30507,'Tuis',305),(30508,'Tayutic',305),(30509,'Santa Rosa',305),(30510,'Tres Equis',305),(30601,'Pacayas',306),(30602,'Cervantes',306),(30603,'Capellades',306),(30701,'San Rafael',307),(30702,'Cot',307),(30703,'Potrero Cerrado',307),(30704,'Cipreses',307),(30705,'Santa Rosa',307),(30801,'El Tejar',308),(30802,'San Isidro',308),(30803,'Tobosi',308),(30804,'Patio de Agua',308),(40101,'Heredia',401),(40102,'Mercedes',401),(40103,'San Francisco',401),(40104,'Ulloa (Barrial)',401),(40105,'Varablanca',401),(40201,'Barba',402),(40202,'San Pedro',402),(40203,'San Pablo',402),(40204,'San Roque',402),(40205,'Santa Lucía',402),(40206,'San José de la Montaña',402),(40301,'Santo Domingo',403),(40302,'San Vicente',403),(40303,'San Miguel',403),(40304,'Paracito',403),(40305,'Santo Tomás',403),(40306,'Santa Rosa',403),(40307,'Tures',403),(40308,'Pará',403),(40401,'Santa Bárbara',404),(40402,'San Pedro',404),(40403,'San Juan',404),(40404,'Jesús',404),(40405,'Santo Domingo',404),(40406,'Puraba',404),(40501,'San Rafael',405),(40502,'San Josesito',405),(40503,'Santiago',405),(40504,'Ángeles',405),(40505,'Concepción',405),(40601,'San Isidro',406),(40602,'San José',406),(40603,'Concepción',406),(40604,'San Francisco',406),(40701,'San Antonio',407),(40702,'La Ribera',407),(40703,'Asunción',407),(40801,'San Joaquín',408),(40802,'Barrantes',408),(40803,'Llorente',408),(40901,'San Pablo',409),(41001,'Puerto Viejo',410),(41002,'La Virgen',410),(41003,'Horquetas',410),(41004,'Llanura del Gaspar',410),(41005,'Curena',410),(50101,'Liberia',501),(50102,'Cañas Dulces',501),(50103,'Mayorga',501),(50104,'Nacascolo',501),(50105,'Curubandé',501),(50201,'Nicoya',502),(50202,'Mansión',502),(50203,'San Antonio',502),(50204,'Quebrada Honda',502),(50205,'Sámara',502),(50206,'Nosara',502),(50207,'Belén de Nosarita',502),(50301,'Santa Cruz',503),(50302,'Bolsón',503),(50303,'Veintisiete de Abril',503),(50304,'Tempate',503),(50305,'Cartagena',503),(50306,'Cuajiniquil',503),(50307,'Diri',503),(50308,'Cabo Velas',503),(50309,'Tamarindo',503),(50401,'Bagaces',504),(50402,'Fortuna',504),(50403,'Mogote',504),(50404,'Río Naranjo',504),(50501,'Filadelfia',505),(50502,'Palmira',505),(50503,'Sardinal',505),(50504,'Belén',505),(50601,'Cañas',506),(50602,'Palmira',506),(50603,'San Miguel',506),(50604,'Bebedero',506),(50605,'Porosal',506),(50701,'Juntas',507),(50702,'Sierra',507),(50703,'San Juan',507),(50704,'Colorado',507),(50801,'Tilarán',508),(50802,'Quebrada Grande',508),(50803,'Tronadora',508),(50804,'Santa Rosa',508),(50805,'Líbano',508),(50806,'Tierras Morenas',508),(50807,'Arenal',508),(50901,'Carmona',509),(50902,'Santa Rita',509),(50903,'Zapotal',509),(50904,'San Pablo',509),(50905,'Porvenir',509),(50906,'Bejuco',509),(51001,'La Cruz',510),(51002,'Santa Cecilia',510),(51003,'Garita',510),(51004,'Santa Elena',510),(51101,'Hojancha',511),(51102,'Monte Romo',511),(51103,'Puerto Carrillo',511),(51104,'Huacas',511),(60101,'Puntarenas',601),(60102,'Pitahaya',601),(60103,'Chomes',601),(60104,'Lepanto',601),(60105,'Paquera',601),(60106,'Manzanillo',601),(60107,'Guacimal',601),(60108,'Barranca',601),(60109,'Monteverde',601),(60110,'Cobano',601),(60111,'Chacarita',601),(60112,'Chira',601),(60113,'Acapulco',601),(60201,'Espíritu Santo',602),(60202,'San Juan Grande',602),(60203,'Macacona',602),(60204,'San Rafael',602),(60205,'San Jerónimo',602),(60301,'Buenos Aires',603),(60302,'Volcí¡n',603),(60303,'Potrero Grande',603),(60304,'Boruca',603),(60305,'Pilas',603),(60306,'Colinas',603),(60307,'Changuena',603),(60308,'Biolley',603),(60401,'Miramar',604),(60402,'Unión',604),(60403,'San Isidro',604),(60501,'Cortés',605),(60502,'Palmar',605),(60503,'Sierpe',605),(60504,'Bahía Ballena',605),(60505,'Piedras Blancas',605),(60601,'Quepos',606),(60602,'Savegre',606),(60603,'Naranjito',606),(60701,'Golfito',607),(60702,'Jiménez',607),(60703,'Guaycar',607),(60704,'Corredor',607),(60801,'San Vito',608),(60802,'Sabalito',608),(60803,'Aguabuena',608),(60804,'Limoncito',608),(60805,'Pittier',608),(60901,'Parrita',609),(61001,'Corredores',610),(61002,'La Cuesta',610),(61003,'Canoas',610),(61004,'Laurel',610),(61101,'Jacó',611),(61102,'Tárcoles',611),(70101,'Limón',701),(70102,'Valle de la Estrella',701),(70103,'Río Blanco',701),(70104,'Matama',701),(70201,'Guí¡piles',702),(70202,'Jiménez',702),(70203,'Rita',702),(70204,'Roxana',702),(70205,'Cariari',702),(70206,'Colorado',702),(70301,'Siquirres',703),(70302,'Pacuarito',703),(70303,'Florida',703),(70304,'Germania',703),(70305,'Cairo',703),(70306,'Alegría',703),(70401,'Bratsi',704),(70402,'Sixaola',704),(70403,'Cahuita',704),(70501,'Matina',705),(70502,'Batán',705),(70503,'Carrandí',705),(70601,'Guácimo',706),(70602,'Mercedes',706),(70603,'Pocora',706),(70604,'Río Jiménez',706),(70605,'Duacarí',706);

INSERT  INTO `distrito`(`codDistrito`,`nombre`,`codCanton`) VALUES
(50901,'Carmona',509),(50902,'Santa Rita',509),(50903,'Zapotal',509),(50904,'San Pablo',509),(50905,'Porvenir',509),(50906,'Bejuco',509);

/*Data for the table cacerio*/

-- DATOS SOLO DE PRUEBA Cacerios o Barrios del distrito Carmona
INSERT INTO cacerio(nombre,codCacerio,codDistrito) VALUES ('El sur',5090101,50901);
INSERT INTO cacerio(nombre,codCacerio,codDistrito) VALUES ('Centro',5090102,50901);
INSERT INTO cacerio(nombre,codCacerio,codDistrito) VALUES ('Bello orizonte',5090103,50901);
INSERT INTO cacerio(nombre,codCacerio,codDistrito) VALUES ('Afganistan',5090104,50901);

-- DATOS SOLO DE PRUEBA Cacerios o Barrios del distrito Santa Rita
INSERT INTO cacerio(nombre,codCacerio,codDistrito) VALUES ('Chimurria',5090201,50902);
INSERT INTO cacerio(nombre,codCacerio,codDistrito) VALUES ('Cruce',5090202,50902);



/*Estado de la solicitud */
INSERT INTO estadosolicitud(nomEstado,codEstado) VALUES('REVISION','R');
INSERT INTO estadosolicitud(nomEstado,codEstado) VALUES('noAPROBADO','N');
INSERT INTO estadosolicitud(nomEstado,codEstado) VALUES('APROBADO','A');
INSERT INTO estadosolicitud(nomEstado,codEstado) VALUES('POSTULANTE','P');


-- Condición socioeconómica
INSERT INTO `condicion`(`idCondicion`,`nomCondicion`) VALUES (1,'Pobreza extrema');
INSERT INTO `condicion`(`idCondicion`,`nomCondicion`) VALUES (2,'Pobreza');
INSERT INTO `condicion`(`idCondicion`,`nomCondicion`) VALUES (3,'Vulnerabilidad');
INSERT INTO `condicion`(`idCondicion`,`nomCondicion`) VALUES (4,'No pobre');

--  Parentesco



INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (1,"SOLICITANTE");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (2,"PADRE");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (3,"MADRE");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (4,"HERMANA");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (5,"HERMAO");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (6,"TIO");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (7,"TIA");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (8,"PRIMO");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (9,"PRIMA");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (10,"ABUELO");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (11,"ABUELA");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (12,"HIJO");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (13,"HIJA");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (14,"BISABUELO");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (15,"BISABUELA");
INSERT INTO `parentesco`(`idParentesco`,`nomParentesco`) VALUES (16,"CUÑADO");


-- grupoMinoritario

INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(1,'Bribí');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(2,'Cabécar');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(3,'Maleku o Guatuso');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(4,'Boruca o Brunca');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(5,'Ngnöme o guaymí');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(6,'Mekatelyo o inglés limonense');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(7,'Huetar');
INSERT INTO grupoMinoritario(idGrupoMinoritario,nomGrupoMinoritario) VALUES(8,'Teribe o Térraba');

-- escolaridad


INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (1,'Sin estudios');
INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (2,'primaria completa');
INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (3,'primaria incompleta');
INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (4,'secundaria completa');
INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (5,'secundaria incompleta');
INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (6,'universidad completa');
INSERT INTO escolaridad(idEscolaridad,nomEscolaridad) VALUES (7,'universidad incompleta');


-- estado conyugal



INSERT INTO estadoConyugal(`idEsdato`,`nomEstado`) VALUES (1,'soltero/a');
INSERT INTO estadoConyugal(`idEsdato`,`nomEstado`) VALUES (2,'casado/a');
INSERT INTO estadoConyugal(`idEsdato`,`nomEstado`) VALUES (3,'unión libre');
INSERT INTO estadoConyugal(`idEsdato`,`nomEstado`) VALUES (4,'viudo/a');
INSERT INTO estadoConyugal(`idEsdato`,`nomEstado`) VALUES (5,'sepeparado/a');

-- TipoUsuario 
INSERT INTO `TipoUsuario`(`Nombre`) VALUES('Estudiante');
INSERT INTO `TipoUsuario`(`Nombre`) VALUES('ComiteBecas');
INSERT INTO `TipoUsuario`(`Nombre`) VALUES('Admin');




/*SP*/