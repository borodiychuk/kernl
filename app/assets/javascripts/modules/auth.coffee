#= require ng-token-auth

angular.module("app.auth", [
  "ng-token-auth"
])

#####################################################################################
##
##  Auth stuff is valid for all cases
##

.config(["$authProvider", "$locationProvider", ($authProvider, $locationProvider) ->

    # Important for proper redirecting of ngTokenAuth
    $locationProvider.html5Mode(true)

    # Oauth
    $authProvider.configure [
      # Need to have it but better prevent it from being used
      {
        default:
          validateOnPageLoad:  false
      }, {
        email:
          apiUrl: "/api"
          tokenValidationPath: "/auth/email/validate_token"
          signOutUrl:          "/auth/email/sign_out"
          emailSignInPath:     "/auth/email/sign_in"
          validateOnPageLoad:  false
      }
    ]
])

.run([
  "$rootScope", "$auth", "$document", "UI", "APIProfile", "$log", "ipCookie"
  ($rootScope,   $auth,   $document,   UI,   APIProfile,   $log,   ipCookie) ->

    loginRedirecter = (event, user) ->
      $log.debug "* Authentication event #{event.name}"
      unless $document[0].location.pathname.match(/^\/app\b/)
        # We need that to receive headers
        APIProfile.get().$promise.then ->
          $document[0].location.href = "/app"
      # No need to redirect user from admin pages to home page, as it is done at rails side

    logoutRedirecter = (event) ->
      $log.debug "* Authentication event #{event.name}"
      if $document[0].location.pathname.match(/^\/app\b/)
        $document[0].location.href = "/reauth"

    # What should happen at successful authenticatetion
    $rootScope.$on "auth:validation-success", loginRedirecter
    $rootScope.$on "auth:login-success",      loginRedirecter

    # What should happen on lost auth
    $rootScope.$on "auth:lost",             logoutRedirecter
    $rootScope.$on "auth:validation-error", logoutRedirecter
    $rootScope.$on "auth:logout-success",   logoutRedirecter
    $rootScope.$on "auth:session-expired",  logoutRedirecter
    $rootScope.$on "auth:login-error",      logoutRedirecter
    $rootScope.$on "auth:lost",             logoutRedirecter
    $rootScope.$on "auth:invalid",          logoutRedirecter

    # Some notifications
    $rootScope.$on "auth:logout-success", -> UI.notify "success", "Erfolgreich abgemeldet!"
    $rootScope.$on "auth:lost",           -> UI.notify "danger",  "Anmeldung fehlt"
    $rootScope.$on "auth:login-error", (response, data) ->
      if data.errors
        UI.notify "danger", e for e in data.errors
      else
        UI.notify "danger", "Anmeldung fehlgeschlagen!"


    # Initial authentication. We try both ways
    $auth.validateUser config: "email"
    $auth.validateUser config: "oauth"

])
