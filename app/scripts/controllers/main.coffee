'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
