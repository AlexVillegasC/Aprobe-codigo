<?php 
	include('../dbAccess/CADusuario.php');
	


	//json_decode convierte un array en un objeto php
	$user= json_decode(file_get_contents('php://input'));//get user from
	$admin = new CADusuario();//Clase de acceso a datos para usuarios Administradores

    //$admin->crear_Admin($user->cedula,$user->clave);


	//Consulta password encriptado del admin con la Cedula
	$dbPassword = $admin->login($user->cedula);
    if(password_verify($user->clave,$dbPassword)) //Si el usuario existe, crea Session
	{ 	
		session_start();
		$_SESSION['uid']=$user->cedula;//uniqid('ang_');////
		print $_SESSION['uid'];
	}
	//$pass_hash =  password_hash(10, PASSWORD_BCRYPT);//Encripta el password	 		
?>