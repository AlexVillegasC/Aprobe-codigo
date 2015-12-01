<?php 
	// ESCRITURA del primer registro de estudiantes matriculas en el año. Solo debe usarse una vez por matricula
	include('../dbAccess/CADusuario.php');
	$cad = new CADusuario();

	$cliente= json_decode(file_get_contents('php://input'),true);//get user from
	$matricula = $cliente['file'];
	$listaEstudiantes = json_decode($matricula,true);

	$n = count($listaEstudiantes['post']);
	$resp = 0;
	for($i = 0;  $i < 5; $i++){
		$estudiante = $listaEstudiantes['post'][$i];
		//print_r($estudiante);
		//print '<br>';
		$sexo = $estudiante['sexo'];
		$beca = NULL;
		$edad = $estudiante['edad'];
		$codigo = $estudiante['codigo'];
		$ap1 = $estudiante['primerApellido'];
		$ap2 = $estudiante['segundoApellido'];
		$nombre = $estudiante['nombre'];
		$idParentesco = $estudiante['idParentesco'];
		$telef = $estudiante['telefonoHogar'];
		$cedula = $estudiante['cedula'];
		$fechaNac = $estudiante['fechaNac'];
		$numNiv = $estudiante['numNivel'];
		$clave = $estudiante['fechaNac'];
		$resp = $cad->crear_matriculaEst($clave,$sexo,$beca,$edad,$codigo,$ap1,$ap2,
		$nombre,$telef,$cedula,$fechaNac,$numNiv);
		//print $resp;


	}
	//registro de bitacora
	session_start();
	print $_SESSION['uid'];
	$cad->registrarEnBitacora($_SESSION['uid'],'insercion de '.$n.' registros, se uso la funcion: crear_matriculaEst');
	

 ?>