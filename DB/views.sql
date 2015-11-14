--LeerCedAdmin_sp : muestre la  lista de los administradores--

create view LeerCedAdmin_vw
			as	(
     SELECT cedula 
     FROM logadmin)

--LeerCedComiteBecas_sp : muestre las cedulas de los comites--

create view LeerCedComiteBecas_vw
			as  (
		SELECT cedula
		FROM logcomitebecas)

--LeerCedEstudiantes_sp : muestre las cedulas de los estudiantes matriculados--

create view LeerCedEstudiantes_vw
			as (
		SELECT cedula
		FROM logestudiante)

--ExtraerListaMatriculados_sp : extraer registros de estudiantes en el sistema en el orden nombre | 1er apelli | 2do apelli | cedula | nivel 

CREATE VIEW ExtraerListaMatriculados_vw
			AS (
		SELECT miembrosfamilia.nombre, miembrosfamilia.primerApellido, miembrosfamilia.segundoApellido, 
		miembrosfamilia.`cedula`, estudiantes.numNivel
		FROM miembrosfamilia, estudiantes, logestudiante
		WHERE miembrosfamilia.`cedula` = logestudiante.`cedula`
		AND  logestudiante.`cedula` = estudiantes.`cedula`)

--el usuario comite puede hacer una consulta extrallendo la siguiente info: nombre | ambos apellidos ordenados por los mismos | cedula | situacion eco. | 
--estado de la solicitud
-- LECTURA de la tabla solicitudestudiante debe hacerse 
DROP VIEW IF EXISTS ListaDeEstudiantes_vw;
CREATE VIEW ListaDeEstudiantes_vw
			AS (
				SELECT miembrosfamilia.nombre, 
				miembrosfamilia.primerApellido, 
				miembrosfamilia.segundoApellido,
				miembrosfamilia.`cedula`,
				`estudiantes`.`numNivel`,
				solicitudestudiante.`tipoBeca`
				FROM miembrosfamilia,`estudiantes`,solicitudestudiante
				WHERE miembrosfamilia.`cedula` = `estudiantes`.`cedula`
				AND `estudiantes`.`cedula` = `solicitudestudiante`.`cedula`
				ORDER BY miembrosfamilia.`primerApellido` ASC
			    );