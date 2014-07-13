'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'MainCtrl', ($scope, oauth, github) ->

    # Bind to Oauth service
    $scope.oauth = oauth

    # Get user credentials
    do updateUserInfo = ->

        # Don't bother if not signed in
        return unless oauth.isSignedIn()

        # Get user data
        github.get '/user'
        .then (res) ->
            # Update user scope params
            $scope.user =
                name: res.data.name
                avatar: res.data.avatar_url
                profile: res.data.html_url


    # Scroll page back to top
    $scope.top = ->
        $('html, body').animate {scrollTop: 0}, 500
        return

    # Listen for signin and prepare UI
    # -----------------------------------------------------------
    # Important: If the $scope isn't being manipulated
    # in this event by come method, then $scope.$apply must
    # be called explicitly to update to the new signed in view
    # -----------------------------------------------------------
    $scope.$on 'oauth_signin', ->

        #Update user data
        do updateUserInfo

    # $scope.$on 'oauth_fail', ->
    #   # TODO: SHOW SOME ERROR DIALOG WHEN AUTH FAILS
