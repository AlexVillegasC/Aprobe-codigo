app.controller('gestionInfoEstCtrl',['$scope','multipartForm','$location',function($scope,multipartForm,$location){
 
	$scope.cliente = {};
	$scope.Submit = function(){
		alert("Espere por favor...");
		multipartForm.post($scope.cliente);
		alert("Listo!");
		$location.path('/homeAdmin');
	};

	//server response
	$scope.response = {};
	multipartForm.getData().then(function(promise){
			$scope.response = promise;
	});

    $scope.listaEst = [];
	$scope.mostrarEstudiantes = function(){
		 $scope.listaEst = $scope.response.data;
		 console.log($scope.listaEst);	
	};



}]);



/*
De la siguiente manera se muestra el dato apenas se cargue la página

	$scope.$watch('response',function(){
		$scope.listaEst = $scope.response.data;

	},true);
*/