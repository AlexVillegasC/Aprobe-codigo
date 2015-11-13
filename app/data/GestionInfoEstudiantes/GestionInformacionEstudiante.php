<?php 

	include('../dbAccess/CADusuario.php');
	$cad = new CADusuario();

	$file= json_decode(file_get_contents('php://input'),true);//get user from
	$matricula = $file['file'];
	$listaEstudiantes = json_decode($matricula,true);

	$n = count($listaEstudiantes['post']);
	$resp = 0;
	for($i = 0;  $i < $n; $i++){
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
		$resp += $cad->crear_matriculaEst($clave,$sexo,$beca,$edad,$codigo,$ap1,$ap2,
		$nombre,$telef,$cedula,$fechaNac,$numNiv);
		print $resp;

	}
	

 ?>