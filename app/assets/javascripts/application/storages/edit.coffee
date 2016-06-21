angular.module("app.controllers").controller "StoragesEditCtrl", [
  "$scope", "$state", "APIStorages", "StateChangeWarner", "UI"
  ($scope,   $state,   APIStorages,   StateChangeWarner,   UI) ->

    $scope.new = $state.params.storage_id is "new"
    StateChangeWarner $scope, "storageForm.$dirty"

    ($scope.reset = ->
      if $scope.new
        $scope.storage = new APIStorages
          name: ""
      else
        $scope.storage = APIStorages.get id: $state.params.storage_id
      $scope.storageForm.$setPristine() if $scope.storageForm?
    )()

    $scope.save = ->
      if $scope.new
        $scope.storage.$save {}, (data) ->
          $scope.storageForm.$setPristine()
          $state.go "^.edit", storage_id: data.id
      else
        $scope.storage.$update {}, $scope.storageForm.$setPristine

    $scope.delete = ->
      UI.confirm ->
        $scope.storage.$delete {}, (data) ->
          $state.go "^.^.list"


]
