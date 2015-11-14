app.controller('gestionInfoEstCtrl',['$scope','multipartForm',function($scope,multipartForm){
 
	$scope.cliente = {};
	$scope.Submit = function(){
		multipartForm.post($scope.cliente);
	};

	//recargar la lista de forma local
	//$scope.lista=multipartForm.leerMatricula();
	//$scope.listaEst = {};

	$scope.mostrarEstudiantes = function(){
		$scope.listaEst =multipartForm.leerMatricula();
		console.log("REPARAR DX, hace 2 request");
	};


}]);