####################################################################################################
##
##  (C) 2012-2015 Andriy Borodiychuk, ab@markusweb.com
##  http://markusweb.com/
##  License: MIT
##
##  Table controller. Table is received either fully (and then paginaion and filtering happens
##  on client side), or partially (paginaton and filetrs are processed on server side).
##
####################################################################################################

angular.module('mwTable', ['ngCookies', 'ngResource'])

# A helper that is used to generate resources which querying can be cancelled by the next query
# Use it in a way:
# .factory('APIEvents', ['Tablify', (Tablify) -> Tablify '/api/private/things/:thing_id/object.json'])
.factory('Tablify', ['$resource', '$q', ($resource, $q) ->
  (url, params = {}) ->
    canceller = $q.defer()
    ->
      canceller.resolve()
      canceller = $q.defer()
      $resource url, params,
        query:  {method: 'GET', timeout: canceller.promise, isArray: true}
        delete: {method: 'DELETE'}
        update: {method: 'PUT'}
])


# Table provider itself
.provider('Table', () ->

  # Default config values can be overriden during configuration
  @name = null
  @type = 'full'
  @filters = all: {}
  @sortingClasses =
    asc: ''
    desc: ''
    none: ''
  @params =
    limit: 20

  # Factory function itself
  @$get = ['$cookieStore', '$filter', '$rootScope', '$log', ($cookieStore, $filter, $rootScope, $log) ->


    # Each table is a new scope, so we have to call the constructor and pass a config to it
    (config) =>

      self = $rootScope.$new()

      # This object keeps the permanent configuration for your table. These parameters are supposed
      # to be defined during page initialization and not to be changed later.
      self.config =
        # The table name. It has to be unique across your domain, because it is used
        # for storing table settings in cookies. Once empty, the settings are not stored
        name: @name
        # MANDATORY OPTION. Type of table. Can be 'full' or 'partial'
        type: @type
        # MANDATORY OPTION. A resource to gt data, ngResource. Must be tablified
        resource: null
        # Filters. Each filter is named and receives an object that is passed to angular's $filter
        # These filters are applied only to full tables
        filters: { all: {} }
        # Initial parameters that will be applied on table initialization.
        # Proiroty is config.params > cookies > default params
        params: {}
        # Classes thay will be used in page header to represent table sorting by specified column
        sortingClasses: @sortingClasses
        # Callback for accessing extra headers. Will receive a header getter function
        httpHeadersCallback: angular.noop

      # This object keeps current parameters, that is selected to table displaying on the webpage.
      # This object is being watched, and when you change it, the table will be rebuilt
      self.params =
        # Records per page
        limit:  @params.limit
        # Page, starting from 1
        page: 1
        # Filter
        filter: 'all'
        # Search term, search string
        search: ''
        # Sorting column
        orderby: ''
        # Reverse sorting flag
        reverse: false

      # This is a representation of table data. Use content of this object to display your table
      self.data =
        # Entries to be display
        display: []
        # Total amount of entries in table
        total: 0
        # Total amount of pages
        pages: 0
        # The number of the first displayed item
        first: 0
        # The nuber of the last displayed item
        last: 0
        # Pages to display in pagination
        paginaion: []

      ##################################################################################################
      ##
      ##  That's all that may be interesting for table usage. Below is just the module logic
      ##
      ##################################################################################################

      ## Apply passed configuration
      angular.extend self.config, config

      ## Check configuration and warn
      if ['full', 'partial'].indexOf(self.config.type) is -1
        $log.warn "Table type is not properly set for module mwTable. Must be either 'full' or 'partial'. Table will not work."
        return self
      unless typeof self.config.resource is 'function'
        $log.warn "Table resource is not properly set for module mwTable. Must be a function. Table will not work."
        return self

      # Restore table parameters from cookies, if they are there
      if self.config.name && $cookieStore.get("tables.#{self.config.name}")
        angular.extend self.params, $cookieStore.get("tables.#{self.config.name}")

      # Apply parameters from config
      angular.extend self.params, self.config.params

      # This flag shows that table was properly initialized, and blocks the launch of operate()
      # until forst data comes
      self.initialized = false

      # Raw table data is stored here, and being watched for changes
      self.raw = []
      self.$watch 'raw', -> self.operate()

      # Watch table parameters for any change, that will mean table rearrangement for us
      self.$watch 'params', ( (oldObj, newObj) ->
        return if angular.equals(oldObj, newObj) and self.initialized
        # Sometimes we need to reload table, e.g. when we know that data on the server may be changed.
        # Table can be forced to reloaded data from the sorce by passing a dummy attribute to config
        forceReload = false
        # So if table was force reloaded, then remove that option, called for convenience 'random'
        if self.params.random?
          delete self.params.random
          forceReload = true
        # Save new table parameters to cookies
        $cookieStore.put "tables.#{self.config.name}", self.params if self.config.name
        if self.config.type is 'full'
          self.operate()
          if forceReload
            data = self.config.resource.query self.params, ((data, headersGetter) ->
              self.initialized = true
              self.config.httpHeadersCallback headersGetter
              self.raw = data
            )
        if self.config.type is 'partial'
          data = self.config.resource().query self.params, ((data, headersGetter) ->
            self.initialized = true
            self.data.total = parseInt(headersGetter('X-Total-Count'), 10) || 0
            self.config.httpHeadersCallback headersGetter
            self.raw = data
          )
      ), true

      # This method does the filtering and pagination for the full table only
      self.operate = ->
        # Avoid run until table is initialized
        return unless self.initialized
        # Format data
        if self.config.type is 'full'
          ordered           = $filter('orderBy')(self.raw, self.params.orderby, self.params.reverse)
          filter_filtered   = $filter('filter')(ordered, self.config.filters[self.params.filter])
          search_filtered   = $filter('filter')(filter_filtered, self.params.search)
          self.data.total   = search_filtered.length
          self.data.pages   = Math.ceil(search_filtered.length / self.params.limit)
          # Reset page if it is too big or too small
          if self.params.page > self.data.pages
            self.params.page = self.data.pages
          self.params.page = 1 if self.params.page < 1
          # Cut the pie
          self.data.display = search_filtered.splice((self.params.page - 1) * self.params.limit, self.params.limit)
        if self.config.type is 'partial'
          self.data.pages = Math.ceil(self.data.total / self.params.limit)
          if self.params.page > self.data.pages
            self.params.page = self.data.pages
          self.params.page = 1 if self.params.page < 1
          self.data.display = self.raw
        # Calculate pagination
        if self.data.total
          # If not empty
          from = (self.params.page - 1) * self.params.limit + 1
          to = self.params.page * self.params.limit
          # Maximum should not be more than total
          to = if to < self.data.total then to else self.data.total
          self.data.first = from
          self.data.last = to
        else
          self.data.first = 0
          self.data.last  = 0
        # Visual pagination
        self.pagination = []
        pages = (num for num in [1..self.data.pages])
        prev = 0
        for page in pages
          if page < 4 or page > self.data.pages - 4 or (page > self.params.page - 3 and page < self.params.page + 3)
            if prev isnt page - 1
              self.pagination.push 0
            self.pagination.push page
            prev = page


      # Set page safely
      self.setPage = (page) ->
        return if page > self.data.pages
        self.params.page = page if page

      # Set the ordering or reverse automatically
      self.setOrderby = (orderby) ->
        if self.params.orderby is orderby
          self.params.reverse = !self.params.reverse
        else
          self.params.orderby = orderby

      # Classname for the column header that does sorting
      self.headerClass = (sorting) ->
        return self.config.sortingClasses.desc if self.params.orderby is sorting && self.params.reverse
        return self.config.sortingClasses.asc if self.params.orderby is sorting && !self.params.reverse
        self.config.sortingClasses.none


      # Force reload table
      self.reload = ->
        self.params.random = Math.random()

      # And reload to launch it immediately
      self.reload()

      # Return the table
      self
  ]

  # We have to return something other than the latest expression
  null
)
