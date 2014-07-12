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

    # Scroll page back to top
    $scope.top = ->
        $('html, body').animate {scrollTop: 0}, 500
        return

    # Listen for signin and apply scope
    $scope.$on 'oauth_success', -> do $scope.$apply

    # $scope.$on 'oauth_fail', ->
    #   # TODO: SHOW SOME ERROR DIALOG WHEN AUTH FAILS
