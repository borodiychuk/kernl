angular.module("app.controllers").controller "ProjectsViewCtrl", [
  "$scope", "$state", "APIProjects"
  ($scope,   $state,   APIProjects) ->

    $scope.project = APIProjects.get id: $state.params.project_id

]
