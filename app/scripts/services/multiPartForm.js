app.service('multipartForm',['$http',function($http){
	//promise
    var listaEst = {};
    listaEst.msj = {};

	listaEst.post = function(data){

		$http.post('data/GestionInfoEstudiantes/guardarMatricula.php',data)
		.then(function(res){
				console.log(res.data);
		});
		listaEst.msj = true;
		return listaEst.msj;
	};
	listaEst.leerMatricula = function(){
		$http.post('data/GestionInfoEstudiantes/leerMatricula.php')
		.then(function(res){
			listaEst.msj = res.data;
			console.log(listaEst.msj.data);
		});
		return listaEst.msj;
	};
	return listaEst;
}])