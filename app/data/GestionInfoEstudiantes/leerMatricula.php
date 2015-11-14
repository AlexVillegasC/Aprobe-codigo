<?php 
	include('../dbAccess/CADusuario.php');
	$cad = new CADusuario();
	print (($cad->leer_Matricula()));
 ?>