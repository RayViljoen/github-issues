'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:IssuesCtrl
 # @description
 # # IssuesCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'IssuesCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
