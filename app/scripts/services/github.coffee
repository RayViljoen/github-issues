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
     # Build GitHub query string
     # @param  {string} path  API request path
     # @param  {object} query Object of name=val query params
     # @return {string}       Final query string (url)
    ###
    apiUrl = (path, query = null) ->

      # Build query
      url = apiHost + path + '?access_token=' + oauth.getAccessToken()

      # Add any available query params
      (url += "&#{param}=#{val}" for param, val of query) if query

      # Return url
      url

    ###
     # Perform a GET rquest to the GitHub API
     # If the request fails due to authorisation,
     # the user is signed out to clear the current access token
     # @param  {string} path   Query path. (As per GitHub docs)
     # @param  {object} params Query parameters (optional)
     # @return {object}        Promise object
    ###
    get = (path, params = null) ->

      # Create a promise
      deffered = do $q.defer

      # Do get request
      $http.get( apiUrl path, params )

        # Resolve promise with success response
        .success (res) -> deffered.resolve res

        # On error
        .error (err, code) ->

          # Reject promise
          deferred.reject err.message

          # Handle auth failure
          if code is 401
            console.log 'Unauthorised API Call. Signing out...'
            # Sign browser out and remove cache to foce re-auth
            do oauth.signOut

        # Return the promise
        deffered.promise


    # Public API here
    { get }
