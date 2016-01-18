angular.module("app.controllers", [])

##
##  Common profile controller
##

.controller("ProfileCtrl", [
  "$scope", "$rootScope", "APIProfile", "UI", "COUNTRIES", "StateChangeWarner", "$auth"
  ($scope,   $rootScope,   APIProfile,   UI,   COUNTRIES,   StateChangeWarner,   $auth) ->

    $scope.countries = COUNTRIES
    StateChangeWarner $scope, "profileForm.$dirty"

    $scope.reset = ->
      $scope.profile = APIProfile.get {}
      $scope.profileForm.$setPristine() if $scope.profileForm

    $auth.validateUser().then $scope.reset
    $scope.$on "auth:login-success",      $scope.reset
    $scope.$on "auth:validation-success", $scope.reset

    $scope.save = ->
      $scope.profile.$update {}, (data) ->
        $scope.profileForm.$setPristine()
        angular.extend $rootScope.user, data

])



##
##  Course pictures management controller
##

.controller("CourseFilesCtrl", [
  "$scope", "IDENTIFIER", "UI", "APICourseFiles", "$state", "$q", "Upload", "$auth", "$timeout"
  ($scope,   IDENTIFIER,   UI,   APICourseFiles,   $state,   $q,   Upload,   $auth,   $timeout) ->

    (loadFiles = ->
      APICourseFiles.query course_id: $state.params.course_id, (data) ->
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
            url: "/api/v1/#{IDENTIFIER}/courses/#{$state.params.course_id}/course_files.json"
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
          APICourseFiles.order course_id: $state.params.course_id, order: data, loadFiles

    $scope.deleteFile = (i) ->
      UI.confirm ->
        i.$delete {}, loadFiles

])
