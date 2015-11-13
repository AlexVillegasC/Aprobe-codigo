app.directive('fileReader', function() {
  return {
    scope: {
      fileReader:"="
    },
    link: function(scope, element) {
      $(element).on('change', function(changeEvent) {
        var files = changeEvent.target.files;
        //console.log(files.length);
        
        if (files.length) {
          var r = new FileReader();
          r.onload = function(e) {
              var contents = e.target.result;
              scope.$apply(function () {
                scope.fileReader = contents;
              });
              //console.log(scope.fileReader + ' in onload');
              //r.readAsText(files[0]);
          };
          console.log('using file-reader directive');
          console.log(r.readAsText(files[0]));
          //r.readAsText(files[0]);
        }
      });
    }
  };
});
