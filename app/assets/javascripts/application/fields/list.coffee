angular.module("app.controllers").controller "FieldsListCtrl", [
  "$scope", "APIFields", "UI", "$state", "Table"
  ($scope,   APIFields,   UI,   $state,   Table) ->

    $scope.fields = Table
      type: "full"
      resource: APIFields
      params:
        storage_id: $state.params.storage_id
        limit: 9999
        page: 1
]
