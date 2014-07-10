'use strict'

###*
 # @ngdoc service
 # @name githubIssuesApp.oauth
 # @description
 # # oauth
 # Service in the githubIssuesApp.
###
angular.module('githubIssuesApp')
  .service 'oauth', ($rootScope, OAUTH_CLIENT_ID) ->

    # Current auth_token
    accessToken = null

    # Init OAuth.io with token caching
    OAuth.initialize OAUTH_CLIENT_ID, cache: yes

    ###
     # Attempt to create a fresh access token
     # Set the new token or null if failed
     # Run this immediattely to attempt setting access_token
     # @return {string} access_token
    ###
    do @getAccessToken = ->

      # Return existing token if exists
      return accessToken if accessToken

      # Else continue to create token
      if tokenObj = OAuth.create 'github'
        accessToken = tokenObj.access_token
      else
        accessToken = null

      # Return access_token
      accessToken


    ###
     # Check whether a access_token exists and is stored
     # @return {Boolean} Whether access token exists ie. signe in
    ###
    @isSignedIn = -> accessToken?


    ###
     # Clear all access tokens (sign out)
     # Fire signout event
    ###
    @signOut = ->
      console.log 'Signed Out'
      OAuth.clearCache 'github'
      accessToken = null


    ###
     # Launches oauth (GitHub) popup.
     # Once popup closes
    ###
    @signIn = ->

      # Auth popup options
      popupOpts =
        cache: yes      # Store access token in browser
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
          accessToken = result.access_token
          $rootScope.$broadcast 'oauth_success'

      return

    # Service shouldn't return anything
    return
