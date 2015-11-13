app.directive('archivoCliente',['$parse',function($parse){
	return {
		restrict:'A',
		link: function(scope,element,attributes){

// lee el valor que esta en el atributo archivo-Cliente, del elemento actual
			var atributoArchivo = $parse(attributes.archivoCliente);
			var setAtributoArchivo = atributoArchivo.assign; //Que hace assign
		
			//watch the element for any kind of changes
			element.bind('change',function(){
				//when a change happend
				scope.$apply(function(){
					setAtributoArchivo(scope,element[0].files[0]);
				});
			});
		}
	}
	
}]);