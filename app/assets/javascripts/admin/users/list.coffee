angular.module("app.controllers").controller "UsersListCtrl", [
  "$scope", "APIUsersTablified", "UI", "Table",
  ($scope,   APIUsersTablified,   UI,   Table) ->

    $scope.users = Table
      name: "users"
      type: "partial"
      resource: APIUsersTablified

]
