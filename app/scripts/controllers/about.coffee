'use strict'

###
 # @ngdoc function
 # @name githubIssuesApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
