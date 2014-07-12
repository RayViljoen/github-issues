'use strict'

###*
 # @ngdoc overview
 # @name githubIssuesApp
 # @description
 # # githubIssuesApp
 #
 # Main module of the application.
###
githubIssuesApp = angular.module('githubIssuesApp', [

    'config'
    'ngRoute'
    'ngTouch'
    'ngStorage'
    'ngAnimate'
    'angular-loading-bar'
    'cgBusy'

  ])

###*
 # Configure App
###
githubIssuesApp.config ($routeProvider, $locationProvider, cfpLoadingBarProvider, TITLE) ->

  # Disable loading bar spinner
  cfpLoadingBarProvider.includeSpinner = no

  # Enable html5mode (no url hashbangs)
  $locationProvider.html5Mode yes

  # Configure Routes
  $routeProvider

    # Issues Summary. Signed in home
    .when '/',
      templateUrl: 'views/issues.html'
      controller: 'IssuesCtrl'

    # Error (404), but error is a bit for app-like
    .when '/error',
      templateUrl: 'views/error.html'
      controller: 'ErrorCtrl'

    # Redirect any unfound requests to /error
    .otherwise redirectTo: '/error'

###*
 # Initialise scripts etc
###
githubIssuesApp.run ->

  # Initialise tasks
  console.log 'ng-ready'

