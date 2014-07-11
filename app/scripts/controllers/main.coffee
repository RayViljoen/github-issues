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

    $scope.testGet = (path, params) ->
        github.get path, params
          .then (res) ->

            console.log res


    # Set auth status
    $scope.authStatus = ->
      do oauth.isSignedIn

    $scope.gh = github

    # Listen for signin and apply scope
    $scope.$on 'oauth_success', -> do $scope.$apply

    # $scope.$on 'oauth_fail', ->
    #   # TODO: SHOW SOME ERROR DIALOG WHEN AUTH FAILS
