angular.module("app.controllers").controller "StoragesViewCtrl", [
  "$scope", "$state", "APIStorages"
  ($scope,   $state,   APIStorages) ->

    $scope.storage = APIStorages.get id: $state.params.storage_id

]
