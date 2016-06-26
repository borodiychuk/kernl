angular.module("app.controllers").controller "FieldsEditCtrl", [
  "$scope", "$rootScope", "$state", "APIFields", "StateChangeWarner", "UI"
  ($scope,   $rootScope,   $state,   APIFields,   StateChangeWarner,   UI) ->

    $scope.new = $state.params.field_id is "new"
    StateChangeWarner $scope, "fieldForm.$dirty"

    ($scope.reset = ->
      if $scope.new
        $scope.field = new APIFields
          name: ""
      else
        $scope.field = APIFields.get id: $state.params.field_id, storage_id: $state.params.storage_id
      $scope.fieldForm.$setPristine() if $scope.fieldForm?
    )()

    $scope.save = ->
      if $scope.new
        $scope.field.$save {storage_id: $state.params.storage_id}, (data) ->
          $scope.fieldForm.$setPristine()
          $state.go $state.current, field_id: data.id
      else
        $scope.field.$update {storage_id: $state.params.storage_id}, ->
          $scope.fieldForm.$setPristine()


    $scope.delete = ->
      UI.confirm ->
        $scope.field.$delete {storage_id: $state.params.storage_id}, (data) ->
          $state.go "^.list"


]
