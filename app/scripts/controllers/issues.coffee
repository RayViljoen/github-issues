'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:IssuesCtrl
 # @description
 # # IssuesCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'IssuesCtrl', ($scope, github) ->

    # Get orgs
    github.getCached('/user/orgs').then (orgs) ->

      # Apply orgs
      $scope.orgs = orgs

      # Stop animation
      $scope.loading = no