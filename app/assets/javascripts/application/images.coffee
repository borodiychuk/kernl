angular.module("app.controllers").controller "ImagesCtrl", [
  "$scope", "UI", "APIImages", "$state", "$q", "Upload", "$auth", "$timeout"
  ($scope,   UI,   APIImages,   $state,   $q,   Upload,   $auth,   $timeout) ->

    (loadFiles = ->
      APIImages.query product_id: $state.params.product_id, (data) ->
        $scope.files = data
    )() unless $scope.new

    (resetProgress =->
      $scope.progress =
        status:   "ready"
        files:    []
        promises: []
    )()

    $scope.uploadFiles = (files) ->
      return unless files && files.length
      $scope.progress.status = "loading"
      for f, i in files
        # Need to get index into closure
        ((file, index) ->
          deferred = $q.defer()
          $scope.progress.promises.push deferred.promise
          $scope.progress.files.push
            progress: 0
            status:   "loading"
            name:     file.name
            size:     file.size
          upload = Upload.upload
            url: "/api/v1/private/products/#{$state.params.product_id}/images.json"
            data:
              file: file
            headers: $auth.retrieveData("auth_headers")
          upload.then (->
            $scope.progress.files[index].status = "success"
            deferred.resolve()
          ), (->
            $scope.progress.files[index].status = "error"
            deferred.resolve()
          ), (evt) ->
            $scope.progress.files[index].progress = parseInt(100.0 * evt.loaded / evt.total)
        )(f, i)
      $q.all($scope.progress.promises).then ->
        $timeout resetProgress, 8000
        loadFiles()

    $scope.sortableOptions =
      placeholder: "sortable-thumbnail-placeholder"
      stop: (event, ui)->
        data = []
        for i, index in ui.item.sortable.sourceModel
          unless i.ordering is index
            data.push
              id:       i.id
              ordering: index
        if data.length
          APIImages.order product_id: $state.params.product_id, order: data, loadFiles

    $scope.deleteFile = (i) ->
      UI.confirm ->
        i.$delete {}, loadFiles

]
