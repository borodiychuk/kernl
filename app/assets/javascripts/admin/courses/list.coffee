angular.module("app.controllers").controller "CoursesListCtrl", [
  "$scope", "APICoursesTablified", "UI", "Table",
  ($scope,   APICoursesTablified,   UI,   Table) ->

    $scope.courses = Table
      name: "courses"
      type: "partial"
      resource: APICoursesTablified

]
