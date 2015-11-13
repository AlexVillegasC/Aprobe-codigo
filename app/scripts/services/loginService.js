"use strict";
app.factory('loginService',function($http,$location	,sessionService){
	return {
		login: function(data,scope){
			var promise = $http.post('data/Sesiones/user.php',data);
			promise.then(function(msg){
				var uid = msg.data;
				if(uid.length > 10) 
				{   //Success
					console.log(uid);
					sessionService.set('user',uid);//key and value are the user object and the unique ID
					$location.path('/homeAdmin');
				}
				else 
				{
					//error i password
					console.log(uid);
					$location.path('/home');
				}
			});
		},
		logout:function(){
			sessionService.destroy('user');
			$location.path('/home');
		},
		islogged:function(){
			//if(sessionService.get('user')) return 'authentified';
			var $checkSessionServer = $http.post('data/Sesiones/check_session.php');
			return $checkSessionServer;
		}
	
	}
});


