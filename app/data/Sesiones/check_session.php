<?php 
	session_start();
	if( isset($_SESSION['uid']) ) {
		include('../dbAccess/CADusuario.php');
		// The next step is get the kind of user value
		$checkSession = new CADusuario();
		$cedula = $_SESSION['uid'];

		$response = $checkSession->tipoSession($cedula);

		print $response	;

	}
?>