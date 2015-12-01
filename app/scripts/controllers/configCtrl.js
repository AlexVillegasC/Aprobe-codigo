app.controller('configCtrl',['$scope','multipartForm','$location',function($scope,multipartForm,$location){
	$scope.cliente = {};
	$scope.Submit = function(){
		multipartForm.post($scope.cliente);
		alert("Espere por favor!");
		$location.path('/gestionInfoEstudiante');
	};

}]);



