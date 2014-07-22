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

    $scope.isHome = -> $location.path() is '/'

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

    # Listen for signin and prepare UI
    # -----------------------------------------------------------
    # Important: If the $scope isn't being manipulated
    # in this event by some method, then $scope.$apply must
    # be called in order to update to the new signed in view
    # -----------------------------------------------------------
    $scope.$on 'oauth_signin', updateUserInfo

    # $scope.$on 'oauth_fail', ->
    #   # TODO: SHOW SOME ERROR DIALOG WHEN AUTH FAILS
