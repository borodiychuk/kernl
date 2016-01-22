angular.module("app.controllers").controller "ProductsEditCtrl", [
  "$scope", "APIProducts", "UI","$state", "StateChangeWarner"
  ($scope,   APIProducts,   UI,  $state,   StateChangeWarner) ->

    $scope.new = $state.params.product_id is "new"
    StateChangeWarner $scope, "productForm.$dirty"

    ($scope.reset = ->
      if $scope.new
        $scope.product = new APIProducts
          project_id: $state.params.project_id
      else
        $scope.product = APIProducts.get id: $state.params.product_id, project_id: $state.params.project_id
      $scope.productForm.$setPristine() if $scope.productForm?
    )()

    $scope.save = ->
      if $scope.new
        $scope.product.$save {}, (data) ->
          $scope.productForm.$setPristine()
          $state.go "^.product", product_id: data.id
      else
        $scope.product.$update {}, $scope.productForm.$setPristine

    $scope.delete = ->
      UI.confirm ->
        $scope.product.$delete {}, (data) ->
          $state.go "^.products"

]
