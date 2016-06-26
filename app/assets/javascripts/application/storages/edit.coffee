angular.module("app.controllers").controller "StoragesEditCtrl", [
  "$scope", "$rootScope", "$state", "APIStorages", "StateChangeWarner", "UI"
  ($scope,   $rootScope,   $state,   APIStorages,   StateChangeWarner,   UI) ->

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
          $rootScope.$broadcast "storages:update"
          $state.go $state.current, storage_id: data.id
      else
        $scope.storage.$update {}, ->
          $scope.storageForm.$setPristine()
          $rootScope.$broadcast "storages:update"


    $scope.delete = ->
      UI.confirm ->
        $scope.storage.$delete {}, (data) ->
          $rootScope.$broadcast "storages:update"
          $state.go "^.^.list"


]
