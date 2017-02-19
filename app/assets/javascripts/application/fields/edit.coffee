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


    ##
    ##  Enum-related logic
    ##

    $scope.addDictionaryItem = ->
      $scope.field.options = {} unless $scope.field.options
      $scope.field.options.dictionary = [] unless $scope.field.options.dictionary
      $scope.field.options.dictionary.push key: "", description: "", group: ""
      $scope.fieldForm.$setDirty()

    $scope.deleteDictionaryItem = (index) ->
      UI.confirm ->
        $scope.$evalAsync ->
          $scope.field.options.dictionary.splice index, 1
          $scope.fieldForm.$setDirty()

    $scope.sortableEnumDictionaryOptions =
      stop: (event, ui)->
        $scope.fieldForm.$setDirty()


]
