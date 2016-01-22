angular.module("app.controllers").controller "ProductsListCtrl", [
  "$scope", "APIProductsTablified", "UI", "$state", "Table",
  ($scope,   APIProductsTablified,   UI,   $state,   Table) ->

    $scope.products = Table
      type: "partial"
      resource: APIProductsTablified
      params:
        project_id: $state.params.project_id
]
