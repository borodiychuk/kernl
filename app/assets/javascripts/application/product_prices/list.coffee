angular.module("app.controllers").controller "ProductPricesListCtrl", [
  "$scope", "APIProductPrices", "UI", "$state", "Table",
  ($scope,   APIProductPrices,   UI,   $state,   Table) ->

    return if $scope.new

    (load = ->
      prices = APIProductPrices.query {product_id: $state.params.product_id}, ->
        $scope.prices = prices
    )()

    $scope.add = ->
      (new APIProductPrices product_id: $state.params.product_id).$save {}, load

    $scope.delete = (p) ->
      UI.confirm ->
        p.$delete {}, load

    $scope.save = (p) ->
      p.$update {}, load

]
