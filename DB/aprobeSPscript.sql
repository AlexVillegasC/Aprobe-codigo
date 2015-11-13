
/*SP*/




/*Les falta la validación y la creación de la transacción*/


	/*Logadmin RU*/

/*Modifca la clave del adminDelColegio según su numero de ced*/
DROP PROCEDURE IF EXISTS ActualizarAdmin_sp;

DELIMITER $$
CREATE PROCEDURE ActualizarAdmin_sp(IN ced VARCHAR(20), IN clav VARCHAR(200))
	BEGIN
		UPDATE `logadmin`
		SET logadmin.`clave` = clav
		WHERE logadmin.`cedula` = ced;
	END; $$
DELIMITER ;



	/*logComiteBecas CRUD*/

/*crear un usuario comiteBecas*/	
DROP PROCEDURE IF EXISTS CrearComiteBecas_sp;
DELIMITER $$

CREATE PROCEDURE CrearComiteBecas_sp(IN ced VARCHAR(20),IN clav VARCHAR(200))
	BEGIN 
	   INSERT INTO logcomitebecas (`cedula`,`clave`) VALUES(ced,clav);  
	END; $$
DELIMITER ;

/*actualizar contraseña comiteBecas*/
DROP PROCEDURE IF EXISTS ActualizarComiteBecas;

DELIMITER $$
CREATE PROCEDURE ActualizarComiteBecas(IN ced VARCHAR(20), IN clav VARCHAR(200))
	BEGIN
		UPDATE logestudiante
		SET logestudiante.`clave` = clav;
	END; $$
DELIMITER ;





	/*logestudiante  CRUD*/

/*Guarda un registro a la vez en la tabla log estudiante*/

DROP PROCEDURE IF EXISTS sp_crearLogEstudiante;

DELIMITER $$
CREATE PROCEDURE sp_crearLogEstudiante(IN ced VARCHAR(20), IN pass VARCHAR(200))
	BEGIN
		INSERT INTO logestudiante (logestudiante.`cedula`,logestudiante.`clave`)
		SELECT * FROM (SELECT ced,pass) AS tmp
		WHERE NOT EXISTS 
		(SELECT logestudiante.cedula 
		 FROM logestudiante
		 WHERE logestudiante.cedula = ced);
	END; $$
DELIMITER ;


/*Actualiza la clase de un registro en la tabla log estudiante*/


DROP PROCEDURE IF EXISTS sp_actualizarLogEstudiante;

DELIMITER $$
CREATE PROCEDURE sp_actualizarLogEstudiante(IN ced VARCHAR(20), IN pass VARCHAR(200))
	BEGIN
		UPDATE logestudiante 
		SET logestudiante.`cedula` = ced, logestudiante.`clave` = pass;
	END; $$
DELIMITER ;


/***********************************************************************/

/*Estudiantes CRUD*/

/*CREATE*/
DROP PROCEDURE IF EXISTS sp_crearEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_crearEstudiante(IN ced VARCHAR(20), IN  fecha_exp DATETIME, IN fecha_nac DATETIME, IN nomDialec VARCHAR(40), IN numNiv INT(11), IN idGmino INT(11) )
	BEGIN
		INSERT INTO `estudiantes` 
		(estudiantes.`cedula`,
		 estudiantes.`fecha_expedicion`,
		 estudiantes.`fecha_nac`,
		 estudiantes.`nomDialecto`,
		 estudiantes.`numNivel`,
		 estudiantes.`idGrupoMinoritario`)
		 VALUES (ced,fecha_exp,fecha_nac,nomDialec,numNiv,idGmino);
	END; $$
DELIMITER ;




/*UPDATE*/
DROP PROCEDURE IF EXISTS sp_actualizarEstudiante;

DELIMITER $$
CREATE PROCEDURE sp_actualizarEstudiante(IN ced VARCHAR(20), IN  fecha_exp DATETIME, IN fecha_nac DATETIME, IN nomDialec VARCHAR(40), IN numNiv INT(11) )
	BEGIN
		UPDATE estudiantes
		SET 
		 estudiantes.`cedula` = ced,
		 estudiantes.`fecha_expedicion` = fecha_exp,
		 estudiantes.`fecha_nac` = fecha_nac,
		 estudiantes.`nomDialecto` = nomDialec,
		 estudiantes.`numNivel` = numNiv;
	END; $$
DELIMITER ;


/*DELETE*/
/*
DROP PROCEDURE IF EXISTS sp_borrarEstudiante;

DELIMITER $$
CREATE PROCEDURE sp_borrarEstudiante(IN ced VARCHAR(20) )
	BEGIN
		DELETE  FROM estudiantes
		WHERE estudiantes.`cedula` = ced;
	END; $$
DELIMITER ;
*/
-- Borra un estudiante y todos sus registros en el sistema
DROP PROCEDURE IF EXISTS sp_borrarEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_borrarEstudiante(IN ced VARCHAR(20))
	BEGIN
		DELETE 
		FROM estudiantes
		WHERE estudiantes.`cedula` = `ced`;
		DELETE
		FROM `logestudiante`
		WHERE   logestudiante.`cedula` = ced;
		DELETE
		FROM `miembrosfamilia`
		WHERE  `miembrosfamilia`.`cedula` = ced;
	END; $$
DELIMITER ;

-- Borra TODOS LOS REGISTROS DE ESTDIANTES NO USAR, SOLO PARA PRUEBAS
DROP PROCEDURE IF EXISTS sp_borrarTODOSEstudiante;
DELIMITER $$
CREATE PROCEDURE sp_borrarTODOSEstudiante()
	BEGIN
		DELETE 
		FROM estudiantes;
		DELETE
		FROM `logestudiante`;
		DELETE
		FROM `miembrosfamilia`;
	END; $$
DELIMITER ;


/*MiembroFamilia CRUD*/

/*CREATE*/






DROP PROCEDURE IF EXISTS sp_crearMiembrosfamilia;

DELIMITER $$
CREATE PROCEDURE sp_crearMiembrosfamilia(IN ced VARCHAR(20),IN nom VARCHAR (40), IN ap1 VARCHAR(40), IN ap2 VARCHAR(40),IN codNaciona INT (11),IN edadE INT (2) ,IN idParent INT(2), IN becasE BOOLEAN, IN idEscolarid INT (2), IN sex  INT (11)  )
	BEGIN
		INSERT INTO `miembrosfamilia`
		(miembrosfamilia.`cedula`,
		 miembrosfamilia.`nombre`,
		 miembrosfamilia.`primerApellido`,
		 miembrosfamilia.`segundoApellido`,
		 miembrosfamilia.`codNacionalidad`,
		 miembrosfamilia.`edad`,
		 miembrosfamilia.`idParentesco`,
		 miembrosfamilia.`becas`,
		 miembrosfamilia.`idEscolaridad`,
		 `MiembrosFamilia`.`sexo`)
		 VALUES (ced,nom,ap1,ap2,codNaciona,edadE,idParent,becasE,idEscolarid,sex);
	END; $$
DELIMITER ;

/*READ*/

DROP PROCEDURE IF EXISTS sp_consultarPasswordAdmin;

DELIMITER $$
CREATE PROCEDURE sp_consultarPasswordAdmin(IN ced VARCHAR(20))
	BEGIN
		SELECT `logadmin`.`clave`
		FROM `logadmin`
		WHERE `logadmin`.`cedula` = ced;
	END; $$
DELIMITER ;


/*UPDATE*/
DROP PROCEDURE IF EXISTS sp_actualizarMiembrosfamilia;

DELIMITER $$
CREATE PROCEDURE sp_actualizarMiembrosfamilia(IN ced VARCHAR(20),IN nom VARCHAR (40), IN ap1 VARCHAR(40), IN ap2 VARCHAR(40),IN codNaciona INT (11),IN edadE INT (2) ,IN idParent INT(2), IN becasE BOOLEAN, IN idEscolarid INT (2)  )
	BEGIN
		UPDATE miembrosfamilia
		SET 
		 miembrosfamilia.`cedula` = ced,
		 miembrosfamilia.`nombre` = nom,
		 miembrosfamilia.`primerApellido` = ap1,
		 miembrosfamilia.`segundoApellido`= ap2,
		 miembrosfamilia.`codNacionalidad`= codNaciona,
		 miembrosfamilia.`edad`   = edadE,
		 miembrosfamilia.`idParentesco`   = idParent,  
		 miembrosfamilia.`becas`  = becasE,
		 miembrosfamilia.`idEscolaridad` = idEscolarid;
	END; $$
DELIMITER ;

/*DELETE*/

DROP PROCEDURE IF EXISTS sp_borrarMiembrosfamilia;

DELIMITER $$
CREATE PROCEDURE sp_borrarMiembrosfamilia(IN ced VARCHAR(20) )
	BEGIN
		DELETE  FROM miembrosfamilia
		WHERE miembrosfamilia.`cedula` = ced;
	END; $$
DELIMITER ;

/*Grupo familiar CRUD*/

/*CREATE*/
DROP PROCEDURE IF EXISTS sp_crearGrupofamiliarPorNuevaMatricula;

DELIMITER $$
CREATE PROCEDURE sp_crearGrupofamiliarPorNuevaMatricula(IN telef INT(11), IN cedEst VARCHAR(20))
	BEGIN
		   INSERT INTO grupofamiliar (telefono,cedEstudiante) 
		   SELECT * FROM (SELECT telef,cedEst) AS tmp
		   WHERE NOT EXISTS 
		   (SELECT GrupoFamiliar.`cedEstudiante` 
		    FROM GrupoFamiliar 
		    WHERE cedEstudiante = cedEst);
	END; $$
DELIMITER ;

/*CREATE*/
DROP PROCEDURE IF EXISTS sp_crearGrupofamiliarPorNuevaMatricula;


/*MiembroFamilia-GrupoFamiliar*/
DROP PROCEDURE IF EXISTS sp_SET_MiembroFam_GrupoFamiliar;

DELIMITER $$
CREATE PROCEDURE sp_SET_MiembroFam_GrupoFamiliar(IN cedEst VARCHAR(20),IN cedMiembro VARCHAR(20))
	BEGIN
		   INSERT INTO `grupofamiliarmiembros` (`idFamilia`,`cedulaMiembro`) 
		   SELECT `grupofamiliar`.`idFamilia`,cedMiembro FROM `grupofamiliar`
		   WHERE `grupofamiliar`.`cedEstudiante` = cedEst;
	END; $$
DELIMITER ;



-- Ejemplo quemado de sp_crearRegistrosEstudiantePorMatricula
/*
CALL `sp_crearRegistrosEstudiantePorMatricula`(1,NULL,19,1,'Villegas','Carranza','Alex Daniel',85283060,'503990937'
,'1994-08-13',12)
*/
DROP PROCEDURE IF EXISTS sp_crearRegistrosEstudiantePorMatricula;

DELIMITER $$
CREATE PROCEDURE sp_crearRegistrosEstudiantePorMatricula(IN clave VARCHAR(200),IN sex INT(11),IN becaE TINYINT(1),IN edadE INT(2),IN codNacional INT (11) ,IN ap1 VARCHAR(40),IN ap2 VARCHAR(40),IN nombre VARCHAR (40),IN telef INT(11), IN cedEst VARCHAR(20),IN fecha_n DATETIME, IN numNiv INT (11) )
	BEGIN  
		DECLARE EXIT HANDLER FOR SQLEXCEPTION 
		BEGIN
		      -- Si sucede una excepción durante la ejecución de los querys
		      ROLLBACK;
		END;
		
		DECLARE EXIT HANDLER FOR SQLWARNING
		BEGIN
		    -- Si sucede un warning durante la ejecución de los querys
		      ROLLBACK;
		END;
		
		START TRANSACTION;
			
			CALL sp_crearEstudiante(cedEst,NULL,fecha_n,NULL,numNiv,NULL);
			CALL sp_crearMiembrosfamilia  (cedEst,nombre,ap1,ap2,codNacional,edadE,1,becaE,4,sex);
			CALL sp_crearGrupofamiliarPorNuevaMatricula (telef,cedEst);
			CALL sp_SET_MiembroFam_GrupoFamiliar(cedEst,cedEst);
			CALL sp_crearLogEstudiante(cedEst,clave);
		COMMIT;
	END; $$
DELIMITER ;
/*
CALL `sp_crearRegistrosEstudiantePorMatricula`(1,1,19,1,'villegas','carranza','alex',3235245,
'9999','1999-10-28',12)
*/




/*En progreso

DROP PROCEDURE IF EXISTS sp_actualizarMatriculado;

DELIMITER $$
CREATE PROCEDURE sp_actualizarMatriculado(IN sex INT(11),IN IDescolaridad INT(2),IN becaE TINYINT(1),IN edadE INT(2),IN codNacional INT (11) ,IN ap1 VARCHAR(40),IN ap2 VARCHAR(40),IN nombre VARCHAR (40),IN idParent INT(11),IN telef INT(11), IN cedEst VARCHAR(20),IN fecha_n DATETIME, IN numNiv INT (11) )
	BEGIN  
		UPDATE miembrosfamilia.
	END; $$
DELIMITER ;
*/


/*
Quemado


INSERT INTO Estudiantes (cedula,fecha_nac,numNivel)
VALUES ('503990937',13/08/1994,12);

INSERT INTO parentesco (idParentesco,nomParentesco)
VALUES (1,'SOLICITANTE');

INSERT INTO escolaridad (idEscolaridad,nomEscolaridad)
VALUES (5,'Educacion media');

INSERT INTO MiembrosFamilia(cedula,
			    nombre,
			    primerApellido,
			    segundoApellido,
			    codNacionalidad,
			    edad,
			    idParentesco,
			    becas,
			    idEscolaridad)
VALUES ('503990937','Alex Daniel','Villegas','Carranza',1,21,1,FALSE,5):

--Inserta solo un grupo familiar con un estudiante
   INSERT INTO grupofamiliar (telefono,cedEstudiante) 
   SELECT * FROM (SELECT '85283060','503990937') AS tmp
   WHERE NOT EXISTS 
   (SELECT GrupoFamiliar.`cedEstudiante` 
    FROM GrupoFamiliar 
    WHERE cedEstudiante = '503990937');
*/