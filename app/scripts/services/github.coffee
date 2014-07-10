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
     # Perform a GET rquest to the GitHub API
     # If the request fails due to authorisation,
     # the user is signed out to clear the current access token
     # @param  {string} path   Query path. (As per GitHub docs)
     # @param  {object} params Query parameters (optional)
     # @return {object}        Promise object
    ###
    get = (path, params = {}) ->

      # Add access_token to params object
      params.access_token = oauth.getAccessToken()

      # Create a promise
      deffered = do $q.defer

      # Do get request
      $http.get( apiHost + path, {params} )

        # Resolve promise with success response
        .success (res) -> deffered.resolve res

        # On error
        .error (err, code) ->

          # Reject promise
          deffered.reject err.message

          # Handle auth failure
          if code is 401
            console.log 'Unauthorised API Call. Signing out...'
            # Sign browser out and remove cache to foce re-auth
            do oauth.signOut

        # Return the promise
        deffered.promise


    # Public API here
    { get }
