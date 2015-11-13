app.controller('gestionInfoEstCtrl',['$scope','multipartForm',function($scope,multipartForm){

	$scope.cliente = {};
	$scope.Submit = function(){
		multipartForm.post($scope.cliente);
	};

}]);