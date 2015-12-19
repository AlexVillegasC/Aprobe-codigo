'use strict';
// Declare app level module which depends on filters, and services
var app = angular.module('myApp', ['ngRoute']);
app.config(['$routeProvider', function($routeProvider) {
	$routeProvider.when('/homeAdmin',{
		templateUrl:'views/homeAdmin.html',
		controller: 'loginAdminCtrl',
		resolve: {
			app: function($q,$timeout){
				var defer = $q.defer();
			
				$timeout(function() {
					defer.resolve();
				},100);
		
				return defer.promise; 
			}
		}
	});
	$routeProvider.when('/home',{
		templateUrl:'views/homeAdmin.html',
		controller: 'loginAdminCtrl',
		resolve: {
			app: function($q,$timeout){
				var defer = $q.defer();
			
				$timeout(function() {
					defer.resolve();
				},100);
		
				return defer.promise; 
			}
		}
	});
	$routeProvider.when('/home',{
		templateUrl:'views/home.html',
		controller: 'loginAdminCtrl',
		resolve: {
			app: function($q,$timeout){
				var defer = $q.defer();
			
				$timeout(function() {
					defer.resolve();
				},100);
		
				return defer.promise; 
			}
		}
	});
	$routeProvider.when('/gestionInfoEstudiante',{
		templateUrl: 'views/gestionInfoEstudiante.html',
		controller: 'gestionInfoEstCtrl',
		resolve: {
			app: function($q,$timeout){
				var defer = $q.defer();
			
				$timeout(function() {
					defer.resolve();
				},100);
		
				return defer.promise; 
			}
		}
	});
	$routeProvider.when('/configuraciones',{
		templateUrl: 'views/configuraciones.html',
		controller: 'configCtrl',
		resolve: {
			app: function($q,$timeout){
				var defer = $q.defer();
			
				$timeout(function() {
					defer.resolve();
				},100);
		
				return defer.promise; 
			}
		}
	});
	$routeProvider.when('/Becas',{
		templateUrl: 'views/formBecas.html',
		controller: 'FormBecasCtrl',
		resolve: {
			app: function($q,$timeout){
				var defer = $q.defer();
			
				$timeout(function() {
					defer.resolve();
				},100);
		
				return defer.promise; 
			}
		}
	});
	$routeProvider.otherwise({redirectTo:'/home'});
}]);


//Remove access to home page without autentication
app.run(function($rootScope,$location,loginService,sessionService){
	var routespermission=['/homeAdmin','/gestionInfoEstudiante']; //Route that require login
	var routespermissionEstudiantes = ['/Becas'];

	console.log("If there's coincidences with the routes: "+routespermission.indexOf($location.path()));
	console.log("Is logged?: "+loginService.islogged());

	$rootScope.$on('$routeChangeStart',function(){
		//When a user is in a Admin path
		if (routespermission.indexOf($location.path()) != -1)
		{
			 //AND there's no session open
			var connected = loginService.islogged();
			connected.then(function(msg){
				//If there's no response from the server
				//Also
				////If there's response, from the server, but the Session if not for an admin user
			    console.log(msg.data);

				if(!msg.data || msg.data == 1){
					console.log(msg.data);
					$location.path('/home');
				}
				
			});
		}
		// If the user is in a Estudiante's Path
		else if(routespermissionEstudiantes.indexOf($location.path()) != -1){
			// And there's no session opened as Estudiante
			var connected = loginService.islogged();
			connected.then(function(msg){
				 console.log(msg.data);
				 if(!msg.data || msg.data == 2 || msg.data == 3){
				 	$location.path("/home");
				 }
			});
		}

	});
});


 