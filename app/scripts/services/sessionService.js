"use strict";
app.factory('sessionService',function($http){
	return {
		set: function(key,value){
			return sessionStorage.setItem(key,value);
		},
		get:  function(key){
			return sessionStorage.getItem(key);
		},
		destroy: function(key){
			//Go and destroy the session in the server
			$http.post('data/destroy_session.php');
			return sessionStorage.removeItem(key);
		}
	};
});