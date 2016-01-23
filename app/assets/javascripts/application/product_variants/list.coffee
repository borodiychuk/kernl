angular.module("app.controllers").controller "ProductVariantsListCtrl", [
  "$scope", "APIProductVariants", "UI", "$state", "Table",
  ($scope,   APIProductVariants,   UI,   $state,   Table) ->

    return if $scope.new

    (load = ->
      variants = APIProductVariants.query {product_id: $state.params.product_id}, ->
        $scope.variants = variants
    )()

    $scope.add = ->
      (new APIProductVariants product_id: $state.params.product_id).$save {}, load

    $scope.delete = (p) ->
      UI.confirm ->
        p.$delete {}, load

    $scope.save = (p) ->
      p.$update {}, load

]
