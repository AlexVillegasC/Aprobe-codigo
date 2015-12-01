-- INSTALAR ANTES QUE LOS SP

DROP FUNCTION IF EXISTS calcular_tipo_usuario;

DELIMITER $$
CREATE  FUNCTION  calcular_tipo_usuario(cedula VARCHAR(20))
RETURNS INT
BEGIN
	SET @res = '';
	SELECT t1.IDUsuario FROM (
	(SELECT `tipousuario_miembro`.`IDUsuario`
	FROM `tipousuario_miembro`
	WHERE `tipousuario_miembro`.`Ced` = cedula) t1
	)
	INTO @res;
	-- select @res;
	RETURN @res;
END; 
$$
DELIMITER ;