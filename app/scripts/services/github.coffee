'use strict'

###*
 # @ngdoc service
 # @name githubIssuesApp.github
 # @description
 # # github
 # Factory in the githubIssuesApp.
###
angular.module('githubIssuesApp')
  .factory 'github', ($http, $q, oauth) ->


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
     # Perform a GET rquest to the GitHub API
     # If the request fails due to authorisation,
     # the user is signed out to clear the current access token
     # @param  {string} path    Query path. (As per GitHub docs)
     # @param  {object} params  Query parameters (optional)
     # @return {object}         Promise object
    ###
    get = (path, params={}) ->

      # Add access_token to params object
      params.access_token = oauth.getAccessToken()

      # Create a promise
      deffered = do $q.defer

      # Do get request
      $http.get( apiHost + path, {params} )

        # Resolve promise with success response
        .success (data, status, headers) ->

          # Get pagination links
          links = parseLinkHeader headers('Link')

          # Resolve promise
          deffered.resolve {data, links}

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


    # Public API here
    { get }
