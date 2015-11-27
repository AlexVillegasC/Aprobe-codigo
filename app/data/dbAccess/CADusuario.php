<?php  
	class CADusuario{

		private $con;
		private $query;
		private $result;

		public function __construct(){
			include('connection.php');	

			$this->con = mysqli_connect($host,$user,$pwd,$db) or die("No se conecto a la base de datos");
			$this->query="";
			$this->result="";
		}

		//inserta los datos del estudiante, en su primer matricula
		function crear_matriculaEst($clave,$sex,$becaE,$edadE,$codNacional,$ap1,$ap2,$nombre,$telef,
			$cedEst,$fecha_n,$numNiv){
			// Cuerpo de la función
			$EncripClave = password_hash($clave, PASSWORD_BCRYPT);
			$this->query = "CALL sp_crearRegistrosEstudiantePorMatricula('$EncripClave',$sex,NULL,$edadE,$codNacional,
			'$ap1','$ap2','$nombre',$telef,'$cedEst',$fecha_n,$numNiv)";
		
	//	$this->query = "CALL sp_crearMiembrosfamilia  ('$cedEst','$nombre','$ap1','ap2',$codNacional,$edadE,1,NULL,4,$sex);";
    //  $this->query  = "CALL sp_crearGrupofamiliarPorNuevaMatricula ($telef,'$cedEst')";
	//$this->query = "CALL sp_SET_MiembroFam_GrupoFamiliar('$cedEst','$cedEst')";
//	$this->query = "INSERT into logestudiante VALUES('$cedEst','$EncripClave')";	
			$this->result = mysqli_query($this->con,$this->query);
			if($this->result === FALSE){
				trigger_error('Query failed returning error: '.mysql_error(),E_USER_ERROR);
			} else {
				return true;
			}
		}

		//inserta un administrador en la base de datos
		function crear_Admin($ced,$pass){
			$pass_hash =  password_hash($pass, PASSWORD_BCRYPT);//Encripta el password
			$this->query = "INSERT into logadmin VALUES('$ced','$pass_hash')";
			$this->result = mysqli_query($this->con,$this->query);

			if($this->result === FALSE){
				 trigger_error('Query failed returning error: '. mysql_error(),E_USER_ERROR);
			} else {	
				return  true;
			}
		}

		// CREAR MÉTODO CONSULTAR ADMIN y CONSULTAR COMITE BECAS


		// Pide cedula y retorna el password
		function log_admin($cedula){

			$this->query = "CALL sp_consultarPasswordAdmin('$cedula')";
			$this->result = mysqli_query($this->con,$this->query);

			if($this->result === FALSE){
				trigger_error('Query failed returning error: '.mysql_error(),E_USER_ERROR);
			}else{

				$clave = $this->result->fetch_assoc();
				return $clave['clave'];//the ced column
			}
		}



		//Metodo para leer la lista de estudiantes matriculados
		function leer_Matricula(){
			$this->query = "SELECT * FROM ListaDeEstudiantes_vw";
			$this->result = mysqli_query($this->con,$this->query);

			if($this->result === FALSE){
				trigger_error('Query failed returnin error: '.mysql_error(),E_USER_ERROR);
			}
			else{
				$row;
				$listaEstudiantes = array();
				while($row = mysqli_fetch_assoc($this->result)){
					array_push($listaEstudiantes,$row);
				}
				return json_encode($listaEstudiantes);
			}
		}

	}

?>