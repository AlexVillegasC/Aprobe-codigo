app.controller('gestionRutasCTRL',['$scope','gestionRutasService',function($scope,gestionRutasService){

	$scope.listDistritos = []; // lista total de distritos
	$scope.listaCacerios = []; //lista total de cacerios

    //Getting the Initial and Intermdian Distrito, ID into a array
	$scope.auxDistrito = []; 
	$scope.auxCacerio = [];

	$scope.codDistrito = [];
	$scope.codCacerio = [];

	$scope.nombresRecorrido = [];
	$scope.numPuntos = 0;

	$scope.valoresRecorrido = [];
	$scope.idRecorrido = [];


    //Waiting for asinchronous response data
	gestionRutasService.leerDistritos().then(function(promise){
		//The distritos local list is setted
		$scope.listDistritos = promise.data;
	});

	gestionRutasService.leerCacerios().then(function(promise){

		$scope.listaCacerios = promise.data;
	});


    //Set the Cacerio List, filter by Distrito
	$scope.desplegarCacerios = function(distrito){
		//initialice Cacerio Dropdownlist text first value.
		$scope.auxCacerio = [];
		//set the value to auxDistrito, is a temporal value for the selected option
	    $scope.auxDistrito = distrito;
	    //Set the filter variable value
		$scope.codDistrito = distrito.codDistrito;
		console.log($scope.codDistrito);
	}

	$scope.establecerPunto = function(cacerio){
		$scope.auxCacerio = cacerio;
		$scope.codCacerio = cacerio.codCacerio;
		console.log($scope.codCacerio);
	}

	$scope.guardarRecorrido = function(distrito,cacerio){

		//Arrays with the name of the Distrito, just to show
		$scope.nombresRecorrido.push(" "+distrito.nombre+" ("+cacerio.nombre+") ");
		//Array with ID from Recorrido, data to secd in a request
		$scope.idRecorrido.push(cacerio.codCacerio); 

		//console
		$scope.numPuntos++;
		console.log($scope.idRecorrido);
	}


	$scope.borrarRecorrido = function(){
		$scope.nombresRecorrido = [];
		$scope.idRecorrido = [];
		$scope.numPuntos = 0;
	}


}]);