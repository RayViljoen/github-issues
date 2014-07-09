'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'MainCtrl', ($scope, Oauth) ->

    # Bind to Oauth service
    $scope.oauth = Oauth

    # Set auth status
    $scope.authStatus = ->
      do Oauth.isSignedIn

    # Listen for signin and apply scope
    $scope.$on 'oauth_success', -> do $scope.$apply

    # $scope.$on 'oauth_fail', ->
    #   # TODO: SHOW SOME ERROR DIALOG WHEN AUTH FAILS
