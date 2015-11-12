'use strict';

app.controller('loginAdminCtrl',['$scope','loginService',function ($scope,loginService){
	$scope.msgtxt = '';

	$scope.Usuario = {
		cedula:'',
		clave:''
	}

	$scope.login = function(Usuario)
	{
		loginService.login($scope.Usuario,$scope);
	}
}]);


