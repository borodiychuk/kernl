angular.module("app.resources.v1.private", ["ngResource"])


##
##  Products
##

.factory("APIProductsTablified", ['Tablify', (Tablify) -> Tablify '/api/v1/private/products/:id/:action.json'])
.factory("APIProducts",  ["$resource", ($resource) ->
  $resource "/api/v1/private/products/:id/:action.json", {id: "@id", project_id: "@project_id"},
    update: {method: "PUT"}
    delete: {method: "DELETE"}
])

.factory("APIImages",  ["$resource", ($resource) ->
  $resource "/api/v1/private/products/:product_id/images/:id/:action.json", {id: "@id", product_id: "@product_id"},
    update: {method: "PUT"}
    delete: {method: "DELETE"}
    order:  {method: "PUT", params: {action: "order"}}
])

.factory("APIProductPrices",  ["$resource", ($resource) ->
  $resource "/api/v1/private/products/:product_id/product_prices/:id/:action.json", {id: "@id", product_id: "@product_id"},
    update: {method: "PUT"}
    delete: {method: "DELETE"}
])

.factory("APIProductVariants",  ["$resource", ($resource) ->
  $resource "/api/v1/private/products/:product_id/product_variants/:id/:action.json", {id: "@id", product_id: "@product_id"},
    update: {method: "PUT"}
    delete: {method: "DELETE"}
])


##
##  Projects
##

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

