angular.module("app.controllers").controller "EntriesEditCtrl", [
  "$scope", "APIEntries", "UI","$state", "StateChangeWarner"
  ($scope,   APIEntries,   UI,  $state,   StateChangeWarner) ->

    $scope.new = $state.params.entry_id is "new"
    StateChangeWarner $scope, "entryForm.$dirty"

    ($scope.reset = ->
      if $scope.new
        $scope.entry = new APIEntries
          storage_id: $state.params.storage_id
      else
        $scope.entry = APIEntries.get id: $state.params.entry_id, storage_id: $state.params.storage_id
      $scope.entryForm.$setPristine() if $scope.entryForm?
    )()

    $scope.save = ->
      if $scope.new
        $scope.entry.$save {}, (data) ->
          $scope.entryForm.$setPristine()
          $state.go "^.entry", entry_id: data.id
      else
        $scope.entry.$update {}, $scope.entryForm.$setPristine

    $scope.delete = ->
      UI.confirm ->
        $scope.entry.$delete {}, (data) ->
          $state.go "^.entries"

]
