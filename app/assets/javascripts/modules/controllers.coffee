angular.module("app.controllers", [])

##
##  Common profile controller
##

.controller("ProfileCtrl", [
  "$scope", "$rootScope", "APIProfile", "UI", "COUNTRIES", "StateChangeWarner", "$auth"
  ($scope,   $rootScope,   APIProfile,   UI,   COUNTRIES,   StateChangeWarner,   $auth) ->

    $scope.countries = COUNTRIES
    StateChangeWarner $scope, "profileForm.$dirty"

    $scope.reset = ->
      $scope.profile = APIProfile.get {}
      $scope.profileForm.$setPristine() if $scope.profileForm

    $auth.validateUser().then $scope.reset
    $scope.$on "auth:login-success",      $scope.reset
    $scope.$on "auth:validation-success", $scope.reset

    $scope.save = ->
      $scope.profile.$update {}, (data) ->
        $scope.profileForm.$setPristine()
        angular.extend $rootScope.user, data

])

