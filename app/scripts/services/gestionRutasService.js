app.factory('gestionRutasService',['$http',function($http){
	return {
		leerDistritos: function(){
			var promise =
			$http({
				method: 'GET',
				url: 'data/GestionRutas/leerDistritos.php'
			}).success(function(data,status,headers,config){
				return data;
			}).error(function(data,status,headers,config){
				return {"status":false};
			});
			return promise;
		},
		leerCacerios: function(){
			var promise =
			$http({
				method:'GET',
				url: 'data/GestionRutas/leerCacerios.php'
			}).success(function(data,status,headers,config){
				return data;
			}).error(function(data,status,headers,config){
				return {"status":false};
			});
			return promise;
		}
	}
}])