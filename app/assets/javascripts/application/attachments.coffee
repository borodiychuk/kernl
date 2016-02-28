angular.module("app.controllers").controller "AttachmentsCtrl", [
  "$scope", "UI", "APIAttachments", "APIValues", "$state", "$q", "Upload", "$auth", "$timeout"
  ($scope,   UI,   APIAttachments,   APIValues,   $state,   $q,   Upload,   $auth,   $timeout) ->

    loadFiles = ->
      APIAttachments.query value_id: $scope.value.id, (data) ->
        $scope.files = data

    $scope.init = (field) ->
      if $scope.new
        $scope.value = APIValues.get id: 0, field: field, storage_id: $state.params.storage_id
      else
        $scope.value = APIValues.get id: 0, field: field, entry_id: $state.params.entry_id
      $scope.value.$promise.then ->
        if $scope.new
          $scope.entry[field] = $scope.value.id
          $scope.entryForm.$setDirty()
        else
          loadFiles()

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
            url: "/api/v2/private/attachments.json"
            data:
              file:     file
              value_id: $scope.value.id
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
          APIAttachments.order value_id: $scope.value.id, order: data, loadFiles

    $scope.deleteFile = (i) ->
      UI.confirm ->
        i.$delete {}, loadFiles

]
