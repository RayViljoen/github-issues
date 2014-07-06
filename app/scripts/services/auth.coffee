'use strict'

###*
 # @ngdoc service
 # @name githubIssuesApp.auth
 # @description
 # # auth
 # Service in the githubIssuesApp.
###
angular.module('githubIssuesApp')
  .service 'Auth', ($location, GITHUB_CLIENT_ID) ->

  	# Config hello.js
  	hello.init github : GITHUB_CLIENT_ID

  	# Configure OAuth
  	authCnf =
  		redirect_uri : '/'
  		scope : 'read:org, repo:status'
  		display : 'page'

  	# Authentication state
  	authenticated = no

  	# Returns current auth state
  	@isAuthenticated = ->
  		console.log 'Checking Auth State'
  		authenticated = hello.getAuthResponse 'github'

  	# Authentication method
  	@login = ->
  		hello.login 'github', authCnf, ->
  			console.log 'Logged In'

  	# Logout method
  	@logout = ->
  		hello.logout 'github', {}, ->
  			console.log 'Logged Out'
  			authenticated = no


  	# Service can't return anything
  	return


