'use strict'

###*
 # @ngdoc service
 # @name githubIssuesApp.oauth
 # @description
 # # oauth
 # Service in the githubIssuesApp.
###
angular.module('githubIssuesApp')
  .service 'Oauth', ($rootScope, OAUTH_CLIENT_ID) ->

    # Current auth_token
    authToken = null

    # Init OAuth.io with token caching
    OAuth.initialize OAUTH_CLIENT_ID, cache: yes


    ###
     # Attempt to create a fresh auth token
     # Set the new token or null if failed
     # Run this immediattely to attempt setting auth_token
     # @return {string} auth_token
    ###
    do @getAuthToken = ->
      if tokenObj = OAuth.create 'github'
        authToken = tokenObj.access_token
      else
        authToken = null

      console.log authToken

      # Return auth_token
      authToken


    ###
     # Check whether a auth_token exists and is stored
     # @return {Boolean} Whether auth token exists ie. signe in
    ###
    @isSignedIn = -> authToken?


    ###
     # Clear all auth tokens (sign out)
     # Fire signout event
    ###
    @signOut = ->
      console.log 'Signed Out'
      OAuth.clearCache 'github'
      authToken = null


    ###
     # Launches oauth (GitHub) popup.
     # Once popup closes
    ###
    @signIn = ->

      # Auth popup options
      popupOpts =
        cache: yes      # Store auth token in browser
        wnd_settings:   # Popup window options
          width: 1080
          height: 650

      # Perform login
      OAuth.popup 'github', popupOpts, (error, result) ->

        # Log and broadcast error if any
        if error
          console.log error
          $rootScope.$broadcast 'oauth_fail'

        # Broadcast success and set auth_token
        else if result.access_token
          console.log 'Signed In'
          authToken = result.access_token
          $rootScope.$broadcast 'oauth_success'

      return

    # Service shouldn't return anything
    return
