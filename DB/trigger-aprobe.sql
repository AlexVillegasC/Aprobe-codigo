/*
DELIMITER $$
CREATE TRIGGER Tr_Insertar_Estudiantes
AFTER INSERT ON estudiantes FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Inserto estudiantes');
END $$
----------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Eliminar_Estudiantes
AFTER DELETE ON estudiantes FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Elimino estudiantes');
END $$
-----------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_Estudiantes
AFTER UPDATE ON estudiantes FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo estudiantes');
END $$
-----------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_Encargado
AFTER UPDATE ON encargados FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo Encargado');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_GrupoFamiliar
AFTER UPDATE ON grupofamiliar FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo Grupo Familiar');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_MiembroFamilia
AFTER UPDATE ON miembrosfamilia FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo Miembro Familia');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Eliminar_Logadmin
AFTER DELETE ON logAdmin FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Elimino Admin');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Eliminar_Logcomitedebecas
AFTER DELETE ON logComiteBecas FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Elimino comite de beca');
END $$
-------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Eliminar_Logestudiante
AFTER DELETE ON logEstudiante FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Elimino Log estudiante');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Insertar_Logadmin
AFTER INSERT ON logAdmin FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Inserto Admin');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Insertar_Logcomitedebecas
AFTER INSERT ON logComiteBecas FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Inserto comite de beca');
END $$
-------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Insertar_Logestudiante
AFTER INSERT ON logEstudiante FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Inserto Log estudiante');
END $$
-------------------------------------------------------
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_Logadmin
AFTER UPDATE ON logAdmin FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo Admin');
END $$
------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_Logcomitedebecas
AFTER UPDATE ON logComiteBecas FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo comite de beca');
END $$
-------------------------------------------------------
DELIMITER $$
CREATE TRIGGER Tr_Actualizar_Logestudiante
AFTER UPDATE ON logEstudiante FOR EACH ROW 
BEGIN 
INSERT INTO bitacora (codigo,fecha,usuarioRealiza,cedulaUsuarioRealiza,justificacion) 
VALUES ('',CURDATE(),USER(),'','Actualizo Log estudiante');
END $$
-------------------------------------------------------
*/
--  Borrar registros relacionados de un estudiante

DROP TRIGGER IF EXISTS TR_borrarRegistrosEstudianteFROMsolicitud;
DELIMITER $$
CREATE TRIGGER TR_borrarRegistrosEstudianteFROMsolicitud
AFTER DELETE ON `solicitudestudiante` FOR EACH ROW
BEGIN
	DELETE FROM `miembrosfamilia` WHERE `miembrosfamilia`.`cedula` = OLD.`cedula`;
	DELETE FROM `logestudiante` WHERE `logestudiante`.`cedula` = OLD.`cedula`;
	DELETE FROM `grupofamiliar` WHERE `grupofamiliar`.`cedEstudiante` = OLD.`cedula`;
	DELETE FROM `estudiantes` WHERE `estudiantes`.cedula =  OLD.`cedula`;
END $$
