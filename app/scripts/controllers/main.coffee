'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'MainCtrl', ($scope, $location, oauth, github) ->

    # Bind to Oauth service
    $scope.oauth = oauth

    # Check if route view should be displayd
    $scope.showRouteView = ->
      path = $location.path()
      oauth.isSignedIn() or path is '/' or path is '/error'

    # Get user credentials
    do updateUserInfo = ->

      # Don't bother if not signed in
      return unless oauth.isSignedIn()

      # Get user data and bind $scope.user
      github.getCached('/user').then (data) ->
        $scope.user = data

    # Scroll page back to top
    $scope.top = ->
      $('html, body').animate {scrollTop: 0}, 500
      return

    # Update user when signing in
    $scope.$on 'oauth_signin', updateUserInfo

    # $scope.$on 'oauth_fail', ->
    #   # TODO: SHOW SOME ERROR DIALOG WHEN AUTH FAILS
