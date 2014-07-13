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

  # Route config for all issue summary paths ( all issues, repo issues, org issues )
  issuesMainCnf =
    templateUrl: 'views/issues.main.html'
    controller: 'IssuesCtrl'
    reloadOnSearch: no

  # Configure Routes
  $routeProvider

    # Issues Summary. Signed in home
    .when '/', issuesMainCnf

    # Issues Summary for specific repo.
    .when '/repo/:repo', issuesMainCnf

    # Issues Summary for specific orginisation.
    .when '/org/:org', issuesMainCnf


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

  # jQuery DOM ready
  # $ ->
    # Toggle all tooltips
    # do $('.init-tooltip').tooltip

