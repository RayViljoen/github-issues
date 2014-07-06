'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the githubIssuesApp
###
angular.module('githubIssuesApp')
  .controller 'MainCtrl', ($scope, $location, Auth) ->

  	console.log $location.url()

  	# bind to the module authenticated state
  	$scope.authd = Auth.isAuthenticated()

  	# Log user out
  	$scope.logout = -> Auth.logout()


  	# /error=required_credentials
  	# error_message=Could not find the credentials that match the provided client_id.
  	# 				Register your app credentials by visiting https//auth-server.herokuapp.com
	# state={
	# 	"client_id" : "0ce081b99794b170e23a"
	# 	"network" : "github"
	# 	"display" : "page"
	# 	"callback" : "_hellojs_8dfagm47"
	# 	"state" : ""
	# 	"oauth_proxy" : "https://auth-server.herokuapp.com/proxy"
	# 	"scope" : "read:org,repo:sta…ithub.com/login/oauth/access_token"
	# 	"response_type" : "code"
	# 	}}