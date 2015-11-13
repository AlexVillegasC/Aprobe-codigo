<?php 
	include('../dbAccess/CADusuario.php');
	


	//json_decode convierte un array en un objeto php
	$user= json_decode(file_get_contents('php://input'));//get user from
	$admin = new CADusuario();//Clase de acceso a datos para usuarios Administradores

	

	//Consulta password encriptado del admin con la Cedula
	$dbPassword = $admin->log_admin($user->cedula);
    if(password_verify($user->clave,$dbPassword)) //Si el usuario existe, crea Session
	{ 	
		session_start();
		$_SESSION['uid']=uniqid('ang_');
		print $_SESSION['uid'];
	}
 	 		

	//$pass_hash =  password_hash(10, PASSWORD_BCRYPT);//Encripta el password
?>


