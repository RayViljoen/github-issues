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
githubIssuesApp.config ($routeProvider, $locationProvider, cfpLoadingBarProvider) ->

  # Disable loading bar spinner
  cfpLoadingBarProvider.includeSpinner = no

  # Enable html5mode (no url hashbangs)
  $locationProvider.html5Mode yes

  # Configure Routes
  $routeProvider

    .when '/',

      templateUrl: 'views/main.html'

    .when '/about',

      templateUrl: 'views/about.html'
      controller: 'AboutCtrl'

    .otherwise redirectTo: '/'

###*
 # Initialise scripts etc
###
githubIssuesApp.run ->

  # Initialise tasks
  console.log 'ng-ready'

