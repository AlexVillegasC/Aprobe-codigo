app.factory('multipartForm',['$http',function($http){
	//promise
	return {
	    getData: function(){
	    	var promise = 
	    	$http({
	    		method: 'GET',
	    		url: 'data/GestionInfoEstudiantes/leerMatricula.php'
	    	}).success(function(data,status,headers, config){
	    		return data;
	    	}).error(function(data,status,headers,config){
	    		return {"status": false};
	    	});
	    	return promise;
	    },	
		post: function(data){
			var request = $http.post('data/GestionInfoEstudiantes/guardarMatricula.php',data);
			
			request.success(function(data,status,headers,config){
				//console.log(data);
			}).error(function(data,status,headers,config){
				return {"status":false};
			});
		}
	}

}])



/*
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
*/