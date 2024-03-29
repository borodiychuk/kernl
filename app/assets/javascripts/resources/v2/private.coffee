angular.module("app.resources.v2.private", ["ngResource"])


##
##  Entries
##

.factory("APIEntriesTablified", ['Tablify', (Tablify) -> Tablify '/api/v2/private/entries/:id/:action.json'])
.factory("APIEntries",  ["$resource", ($resource) ->
  $resource "/api/v2/private/entries/:id/:action.json", {id: "@id", storage_id: "@storage_id"},
    update: {method: "PUT"}
])


##
##  Values
##

.factory("APIValues",  ["$resource", ($resource) ->
  $resource "/api/v2/private/values/:id/:action.json", {id: "@id"}
])


##
##  Attachments
##

.factory("APIAttachments",  ["$resource", ($resource) ->
  $resource "/api/v2/private/attachments/:id/:action.json", {id: "@id", value_id: "@value_id"},
    update: {method: "PUT"}
    order:  {method: "PUT", params: {action: "order"}}
])


##
##  Storages
##

.factory("APIStorages",  ["$resource", ($resource) ->
  $resource "/api/v2/private/storages/:id/:action.json", {id: "@id"},
    update: {method: "PUT"}
])


##
##  Profile
##

.factory("APIProfile",  ["$resource", ($resource) ->
  $resource "/api/v2/private/profile.json", {},
    update: {method: "PUT"}
])


##
##  Fields
##

.factory("APIFields",  ["$resource", ($resource) ->
  $resource "/api/v2/private/fields/:id/:action.json", {id: "@id"},
    update: {method: "PUT"}
])
