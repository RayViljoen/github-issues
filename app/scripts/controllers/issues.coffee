'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:IssuesCtrl
 # @description
 # # IssuesCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'IssuesCtrl', ($scope, $routeParams) ->

    # Check if this is issues for a specific repo
    repo = $routeParams.repo

    # Check if this is issues for a specific orginisation only
    org = $routeParams.org
