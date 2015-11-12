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


	}

?>