'use strict';
// Declare app level module which depends on filters, and services
var app = angular.module('myApp', ['ngRoute']);
app.config(['$routeProvider', function($routeProvider) {
	$routeProvider.when('/homeAdmin',{
		templateUrl:'views/homeAdmin.html',
		controller: 'loginAdminCtrl'
	});
	$routeProvider.when('/home',{
		templateUrl:'views/homeAdmin.html',
		controller: 'loginAdminCtrl'
	});
	$routeProvider.when('/home',{
		templateUrl:'views/home.html',
		controller: 'loginAdminCtrl'
	});
	$routeProvider.when('/gestionInfoEstudiante',{
		templateUrl: 'views/gestionInfoEstudiante.html',
		controller: 'gestionInfoEstCtrl'
	});
	$routeProvider.when('/configuraciones',{
		templateUrl: 'views/configuraciones.html',
		controller: 'configCtrl'
	});
	$routeProvider.otherwise({redirectTo:'/home'});
}]);


//Remove access to home page without autentication
app.run(function($rootScope,$location,loginService,sessionService){
	var routespermission=['/homeAdmin','/gestionInfoEstudiante']; //Route that require login

	console.log("If there's coincidences with the routes: "+routespermission.indexOf($location.path()));
	console.log("Is logged?: "+loginService.islogged());

	$rootScope.$on('$routeChangeStart',function(){
		//When a user is in the home path
		if (routespermission.indexOf($location.path()) != -1)
		{
			 //AND there's no session open
			var connected = loginService.islogged();
			connected.then(function(msg){
				//If there's no response from the server
				if(!msg.data){
					$location.path('/home');
				}
			});
		}

	});
});


 