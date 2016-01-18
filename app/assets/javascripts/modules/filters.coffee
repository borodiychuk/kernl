angular.module("app.filters", [])

##
##  Textual representation for country
##

.filter("country", ["COUNTRIES", (COUNTRIES) ->
  (code) ->
    COUNTRIES[code] || code
])


##
##  Proper formatting for file sizes
##

.filter("bytes", ->
  (bytes, precision) ->
    return "-" if isNaN(parseFloat(bytes)) || !isFinite(bytes)
    precision = 1 if typeof precision is "undefined"
    units = ["B", "kB", "MB", "GB", "TB", "PB"]
    number = Math.floor Math.log(bytes) / Math.log(1024)
    (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision) +  " " + units[number]
)
