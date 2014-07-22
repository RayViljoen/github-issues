'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:IssuesCtrl
 # @description
 # # IssuesCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'IssuesCtrl', ($scope, $location, $routeParams, github) ->

    # Get possible routeparams
    $scope.owner = $routeParams.owner or $routeParams.org
    $scope.repo = $routeParams.repo

    # Also check for users own repos being used
    if $location.path() is '/user/issues'
      $scope.owner = $scope.$parent.user.login


    # Load issues
    github.query $location.path(), $location.search(), yes
    .then (res) -> console.log res