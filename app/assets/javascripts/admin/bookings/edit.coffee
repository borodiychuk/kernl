angular.module("app.controllers").controller "BookingsEditCtrl", [
  "$scope", "APIBookings", "UI", "$state", "StateChangeWarner"
  ($scope,   APIBookings,   UI,   $state,   StateChangeWarner) ->

    StateChangeWarner $scope, "bookingForm.$dirty"

    ($scope.reset = ->
      APIBookings.get id: $state.params.booking_id, (data) ->
        $scope.booking = data
      $scope.bookingForm.$setPristine() if $scope.bookingForm?
    )()

    $scope.save = ->
      $scope.booking.$update {}, $scope.bookingForm.$setPristine

    $scope.delete = ->
      UI.confirm ->
        $scope.booking.$delete {}, (data) ->
          $state.go "bookings.list"


    $scope.setNoShow = ->
      $scope.booking.$setNoShow()

    $scope.resetNoShow = ->
      $scope.booking.$resetNoShow()

    $scope.setCancelled = ->
      $scope.booking.$setCancelled()

    $scope.resetCancelled = ->
      $scope.booking.$resetCancelled()













]
