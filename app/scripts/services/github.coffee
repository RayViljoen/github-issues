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

        # Parse 'rel'.
        # Match ( rel="next), and remove first 6 chars from match[0]
        # First 6 chars being ( rel=")
        rel = link.match(/\srel="\w*/i)[0][6..]

        # Parse 'page'
        # Match (&page=1), and remove first 6 chars from match[0]
        # First 6 chars being (&page=)
        # IMPORTANT pattern includes leading & or ?
        # This ensures it is the correct param
        # e.g. Otherwise 'per_page' param would also match
        page = link.match(/[?&]page=\d*/i)[0][6..]
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
     # Duplicate of `query`, but performs all paginated requests.
     # All paginated results get merged and resolved by single promise
     # Requests are still done via the standard query function, so error
     # handling, options etc. is unchanged.
     # the user is signed out to clear the current access token
     # @param  {string} path    Query path. (As per GitHub docs)
     # @param  {object} params  Query parameters (optional)
     # @return {object}         Promise object
    ###
    queryAll = (path, params={}) ->

      # Force per_page: 100 and page: 1
      # Cannot see any situation the max wouldn't apply to this function
      params.per_page = 100
      params.page = 1

      # Create a promise
      deffered = do $q.defer

      # Rsponse array
      response = []

      # Perform request starting at page 1
      # If links.next exists then request that etc.
      do getPage = (page=1) ->

        # Set page to query params
        params.page = page

        # Do query with links obviously
        query(path, params, yes).then (res) ->

          # Concat the res.data to the response array
          response = response.concat res.data

          # If another page exists (next), then call
          # this fn again with the next page number
          if res.links and res.links.next then getPage res.links.next

          # Else we've reached the last page, so
          # resolve with the response array
          else deffered.resolve response

      # Return the promise
      deffered.promise


    ###
     # Perform a GET rquest to the GitHub API
     # If the request fails due to authorisation,
     # the user is signed out to clear the current access token
     # @param  {string} path    Query path. (As per GitHub docs)
     # @param  {object} params  Query parameters (optional)
     # @param  {bool}   doLinks Includes pagination object in promise val
     # @return {object}         Promise object
    ###
    query = (path, params={}, doLinks) ->

      # Prepare path
      path = preparePath(path)

      # Add access_token to params object
      params.access_token = oauth.getAccessToken()

      # Set max number of results default
      params.per_page or= 100

      # Create a promise
      deffered = do $q.defer

      # Do get request
      p = $http.get( apiHost + path, {params} )

        # Resolve promise with success response
      p.success (data, status, headers) ->

        # Get pagination links if doLinks option is set
        links = parseLinkHeader headers('Link') if doLinks

        # Create res object
        res = if doLinks then {data, links} else data

        # Resolve promise
        deffered.resolve res

      # On error
      p.error (err, code) ->

        # Reject promise
        deffered.reject err.message

        # TODO: Handle simple request error with notification of some sort
        # Possibly have a try again button or something

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
     # Can also be forced to refresh data.
     # Key used for storage/cache is generated based on the query path.
     #
     #   This function should be treated as a standard query with the exception
     #   of not supporting links (paginated cache makes no sense) and having the
     #   refresh option.
     #
     #   The params object also supports a custom `queryall` param.
     #   If `queryall` is true then queryAll will be used instead of query
     #
     # @param  {string} path     Query path. (As per GitHub docs)
     # @param  {object} params   Query parameters (optional)
     # @param  {bool}   refresh  If true then cache is refreshed
     # @return {object}          Promise object
    ###
    getCached = (path, params={}, refresh) ->

      # Create a promise
      deffered = do $q.defer

      # Get cache key
      key = createCacheKey path

      # ------------------------------------------------------------
      # Backup function for if cache isn't set
      queryData = ->

        # Check whether results needs to use queryAll or just query
        qfn = if params.queryall then queryAll else query
        # Do query/queryAll
        qfn(path, params).then (data) ->

          # Store data
          $localForage.setItem key, data

          # Resolve promise with new query data
          deffered.resolve data
      # ------------------------------------------------------------

      # Try to get cached data unless forced to refresh
      unless refresh then $localForage.getItem(key).then (data) ->

        # If cache isn't set then do query
        if data is null then do queryData

        # Else simply resolve with cache data
        else deffered.resolve data

      # Else if forced to refresh go straight to query
      else do queryData

      # Return the promise
      deffered.promise


    ###
     # A special helper function for retreiving ALL
     # repos a user is associated with. To do this we
     # get the user's own repos and then add the repos
     # from each orginization the user belongs to.
     # @param  {bool}   refresh  If true then cache is refreshed
     # @return {object}          Promise object
    ###
    getRepos = (refresh) ->

      # Final repos array
      repos = []

      # Create a promise
      deffered = do $q.defer

      # ------------------------------------------------------------
      # Backup function for if cache isn't set
      queryRepos = ->

        # Get user orgs. Doing getCached as this is as
        # good an oppertunity as any to update the cached orgs.
        getCached('/user/orgs', null, yes).then (orgs) ->

          # Collection of promises to pass to $.all
          queries = []

          # User's own repos
          queries.push queryAll('/user/repos')

          # User's org repos
          for org in orgs
            queries.push queryAll("/orgs/#{org.login}/repos")

          # Process all promises
          $q.all(queries).then (repos) ->

            # Flatten individual results (shallow)
            repos = _.flatten repos, yes

            # Store repos
            $localForage.setItem 'repos', repos

            # Resolve response promise
            deffered.resolve repos
      # ------------------------------------------------------------

      # Try to get cached data unless forced to refresh
      unless refresh then $localForage.getItem('repos').then (cachedRepos) ->

        # If cache isn't set then do query
        if cachedRepos is null then do queryRepos

        # Else simply resolve with cache data
        else deffered.resolve cachedRepos

      # Else if forced to refresh go straight to query
      else do queryRepos

      # Return the promise
      deffered.promise


    ########################################################
    # Return Public API
    { query, queryAll, getCached, getRepos }

