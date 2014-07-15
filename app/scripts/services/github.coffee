'use strict'

###*
 # @ngdoc service
 # @name githubIssuesApp.github
 # @description
 # # github
 # Factory in the githubIssuesApp.
###
angular.module('githubIssuesApp')
  .factory 'github', ($http, $q, $localForage, oauth) ->

    # API Hostname
    apiHost = 'https://api.github.com'


    ###
     # Parses standard 'Link' header into {rel:page} format
     # @param  {string} linkHeader Header returned from API
     # @return {object}            Response object {rel:page}
    ###
    parseLinkHeader = (linkHeader) ->

      # Return if no linkHeader
      return null unless linkHeader

      # Split links in header
      links = linkHeader.split ','

      # Create response object
      res = {}

      # Loop links
      for link in links
        # Parse 'rel'
        rel = (link.match /rel="\w*/i)[0].replace 'rel="', ''
        # Parse 'page'
        page = (link.match /page=\d*/i)[0].replace 'page=', ''
        # Add to response object
        res[rel] = page

      # Return
      res

    ###
     # Creates a formatted path to use as cahce key
     # @param  {string} path Query path to format
     # @return {string}      Formatted path
    ###
    createCacheKey = (path) ->

      # Remove leading and trailinf slashes
      path = path.replace /\/$/, ''
      path = path.replace /^\//, ''

      # Replace '/''s with . and return path
      path = path.replace '/', '.'


    ###
     # Adds leading slash and removes trailing slash from path
     # @param  {string} path The string to prepare
     # @return {string}      Prepared path
    ###
    preparePath = (path) ->

      # Add leading slash
      path = '/' + path unless path[0] is '/'

      # Remove trailing slash
      path = path.replace /\/$/, ''

      # Return path
      path


    ###
     # Duplicate of `query`, but performs pagination requests.
     # All pagination requests get merged and resolved by single promise
     # Requests are still done via the standard query function, so error
     # handling, options etc. is unchanged.
     # the user is signed out to clear the current access token
     # @param  {string} path    Query path. (As per GitHub docs)
     # @param  {object} params  Query parameters (optional)
     # @param  {bool}   links   If truth then promise response will include pagination object
     # @return {object}         Promise object
    ###
    queryAll = (path, params={}, getLinks) -> null


    ###
     # Perform a GET rquest to the GitHub API
     # If the request fails due to authorisation,
     # the user is signed out to clear the current access token
     # @param  {string} path    Query path. (As per GitHub docs)
     # @param  {object} params  Query parameters (optional)
     # @param  {bool}   links   If truth then promise response will include pagination object
     # @return {object}         Promise object
    ###
    query = (path, params={}, getlinks) ->

      # Prepare path
      path = preparePath(path)

      # Add access_token to params object
      params.access_token = oauth.getAccessToken()

      # Set max number of results default
      params.per_page or= 100

      # Create a promise
      deffered = do $q.defer

      # Do get request
      $http.get( apiHost + path, {params} )

        # Resolve promise with success response
        .success (data, status, headers) ->

          # Get pagination links if links option is set
          links = parseLinkHeader headers('Link') if getlinks

          # Create res object
          res = if links then {data, links} else data

          # Resolve promise
          deffered.resolve res

        # On error
        .error (err, code) ->

          # Reject promise
          deffered.reject err.message

          # Handle auth failure
          if code is 401
            console.log 'Unauthorised API Call'
            console.log 'Signing out'
            # Sign browser out and remove cache to foce re-auth
            do oauth.signOut

        # Return the promise
        deffered.promise



    ###
     # Mimics query functions, but attempts to retreive from storage (cache).
     # If cached key isn't set, then it's queried and stored.
     # Can also be forced to update data.
     # Key used for storage/cache is generated based on the query path.
     #
     #   This function should be treated as a standard query with the exception
     #   of not supporting links (paginated cache makes no sense) and having the
     #   update option.
     #
     #   The params object also supports a custom `queryall` param.
     #   If `queryall` is true then queryAll will be used instead of query
     #
     # @param  {string} path    Query path. (As per GitHub docs)
     # @param  {object} params  Query parameters (optional)
     # @param  {bool}   update  If true then cache is updated
     # @return {object}         Promise object
    ###
    getCached = (path, params={}, update) ->

      # Get cache key
      key = createCacheKey path

      # Check whether results needs to use queryAll or just query
      qfn = if params.queryall then queryAll else query

      # Create a promise
      deffered = do $q.defer

      # Try to get cached data
      $localForage.getItem(key).then (data) ->
        # If forced to update ot cache returned null
        # then do query
        if update or not data
          qfn(path, params).then (data) ->

            # Store/update data
            $localForage.setItem key, data

            # Resolve promise with new query data
            deffered.resolve data

        # Else simply resolve with cache data
        else deffered.resolve data

      # Return the promise
      deffered.promise





    ########################################################
    # Return Public API
    { query, queryAll, getCached }
