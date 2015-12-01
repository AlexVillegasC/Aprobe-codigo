app.controller('gestionInfoEstCtrl',['$scope','multipartForm',function($scope,multipartForm){
 
	
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