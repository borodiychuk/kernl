angular.module("app.resources.v1.private", ["ngResource"])


##
##  Projects
##


.factory("APIProjectsTablified", ['Tablify', (Tablify) -> Tablify '/api/v1/private/projects/:id/:action.json'])
.factory("APIProjects",  ["$resource", ($resource) ->
  $resource "/api/v1/private/projects/:id/:action.json", {id: "@id"}
])


##
##  Profile
##

.factory("APIProfile",  ["$resource", ($resource) ->
  $resource "/api/v1/private/profile.json", {},
    update: {method: "PUT"}
])

