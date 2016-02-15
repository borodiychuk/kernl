angular.module("app.controllers").controller "FilesEditCtrl", [
  "$scope", "APIFiles", "UI","$state", "StateChangeWarner"
  ($scope,   APIFiles,   UI,  $state,   StateChangeWarner) ->

    StateChangeWarner $scope, "fileForm.$dirty"

    ($scope.reset = ->
      $scope.file = APIFiles.get id: $state.params.file_id, project_id: $state.params.project_id
      $scope.fileForm.$setPristine() if $scope.fileForm?
    )()

    $scope.save = ->
      $scope.file.$update {}, $scope.fileForm.$setPristine

    $scope.delete = ->
      UI.confirm ->
        $scope.file.$delete {}, (data) ->
          $state.go "^.products"

]
