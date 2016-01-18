angular.module("app.controllers").controller "ProjectsListCtrl", [
  "$scope", "APIProjects", "UI", "Table",
  ($scope,   APIProjects,   UI,   Table) ->

    $scope.projects = Table
      type: "full"
      resource: APIProjects
      params:
        limit: 100

]
