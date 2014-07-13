'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:ErrorCtrl
 # @description
 # # ErrorCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'ErrorCtrl', ($scope, $location, $timeout, $interval, oauth) ->

    # Simple home redirect fn
    goHome = -> $location.path '/'

    # If user signs out on error page simply go home
    $scope.$on 'oauth_signout', goHome

    # If user isn't signed in, then there's no point
    # in showig this page, so simply go home
    do goHome unless oauth.isSignedIn()
