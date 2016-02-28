angular.module("app.controllers").controller "EntriesListCtrl", [
  "$scope", "APIEntriesTablified", "UI", "$state", "Table"
  ($scope,   APIEntriesTablified,   UI,   $state,   Table) ->

    $scope.entries = Table
      type: "partial"
      resource: APIEntriesTablified
      params:
        storage_id: $state.params.storage_id
]
