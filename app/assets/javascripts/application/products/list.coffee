angular.module("app.controllers").controller "ProductsListCtrl", [
  "$scope", "APIProductsTablified", "UI", "$state", "Table", "APIFiles", "Upload", "$q", "$auth", "$timeout"
  ($scope,   APIProductsTablified,   UI,   $state,   Table,   APIFiles,   Upload,   $q,   $auth,   $timeout) ->

    $scope.products = Table
      type: "partial"
      resource: APIProductsTablified
      params:
        project_id: $state.params.project_id


    $scope.files = Table
      resource: APIFiles
      params:
        project_id: $state.params.project_id


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
            url: "/api/v1/private/files.json"
            data:
              file: file
              project_id: $state.params.project_id
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
        $scope.files.reload()







]
