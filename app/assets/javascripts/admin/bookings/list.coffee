angular.module("app.controllers").controller "BookingsListCtrl", [
  "$scope", "APIBookingsTablified", "UI", "Table", "APICourses"
  ($scope,   APIBookingsTablified,   UI,   Table,   APICourses) ->

    $scope.courses = APICourses.query()

    $scope.bookings = Table
      name: "a_bookings"
      type: "partial"
      resource: APIBookingsTablified
      httpHeadersCallback: (getter) ->
        $scope.totalPrice     = parseFloat getter('X-Total-Price')
        $scope.totalProvision = parseFloat getter('X-Total-Provision')
      params:
        _marker: "bookings"


]
