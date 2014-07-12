'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:ErrorCtrl
 # @description
 # # ErrorCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'ErrorCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
