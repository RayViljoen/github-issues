'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:LoginCtrl
 # @description
 # # LoginCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'LoginCtrl', ($scope, Auth) ->

  	$scope.authenticate = ->
  		Auth.login()