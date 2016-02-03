-- LeerCedAdmin_sp : muestre la  lista de los administradores--

CREATE VIEW LeerCedAdmin_vw
			AS	(
     SELECT cedula 
     FROM logadmin)

-- LeerCedComiteBecas_sp : muestre las cedulas de los comites--

CREATE VIEW LeerCedComiteBecas_vw
			AS  (
		SELECT cedula
		FROM logcomitebecas)

-- LeerCedEstudiantes_sp : muestre las cedulas de los estudiantes matriculados--

CREATE VIEW LeerCedEstudiantes_vw
			AS (
		SELECT cedula
		FROM logestudiante)

-- ExtraerListaMatriculados_sp : extraer registros de estudiantes en el sistema en el orden nombre | 1er apelli | 2do apelli | cedula | nivel 

CREATE VIEW ExtraerListaMatriculados_vw
			AS (
		SELECT Persona.nombre, Persona.primerApellido, Persona.segundoApellido, 
		Persona.`cedula`, estudiantes.numNivel
		FROM Persona, estudiantes, logestudiante
		WHERE Persona.`cedula` = logestudiante.`cedula`
		AND  logestudiante.`cedula` = estudiantes.`cedula`)

-- el usuario comite puede hacer una consulta extrallendo la siguiente info: nombre | ambos apellidos ordenados por los mismos | cedula | situacion eco. | 
-- estado de la solicitud
-- LECTURA de la tabla solicitudestudiante debe hacerse 
DROP VIEW IF EXISTS ListaDeEstudiantes_vw;
CREATE VIEW ListaDeEstudiantes_vw
			AS (
				SELECT Persona.nombre, 
				Persona.primerApellido, 
				Persona.segundoApellido,
				Persona.`cedula`,
				`estudiantes`.`numNivel`,
				solicitudestudiante.`tipoBeca`
				FROM Persona,`estudiantes`,solicitudestudiante
				WHERE Persona.`cedula` = `estudiantes`.`cedula`
				AND `estudiantes`.`cedula` = `solicitudestudiante`.`cedula`
				ORDER BY Persona.`primerApellido` ASC
			    );