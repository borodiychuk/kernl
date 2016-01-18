angular.module("app.controllers").controller "UsersEditCtrl", [
  "$scope", "APIUsers", "UI", "COUNTRIES", "$state", "StateChangeWarner"
  ($scope,   APIUsers,   UI,   COUNTRIES,   $state,   StateChangeWarner) ->

    $scope.countries = COUNTRIES
    $scope.new = $state.params.user_id is "new"
    StateChangeWarner $scope, "userForm.$dirty"

    ($scope.reset = ->
      if $scope.new
        $scope.user = new APIUsers
                        license: "player"
                        subscribed_for_newsletter: false
      else
        APIUsers.get id: $state.params.user_id, (data) ->
          $scope.user = data
      $scope.userForm.$setPristine() if $scope.userForm?
    )()

    $scope.save = ->
      if $scope.new
        $scope.user.$save {}, (data) ->
          $state.go "users.edit", user_id: data.id
      else
        $scope.user.$update {}, $scope.userForm.$setPristine

    $scope.delete = ->
      UI.confirm ->
        $scope.user.$delete {}, (data) ->
          $state.go "users.list"

]
