angular.module("app.controllers").controller "StoragesListCtrl", [
  "$scope", "APIStorages", "UI", "Table",
  ($scope,   APIStorages,   UI,   Table) ->

    $scope.storages = Table
      type: "full"
      resource: APIStorages
      params:
        limit: 100

    $scope.$on "storages:update", $scope.storages.reload

]
