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
    'LocalForageModule'
    'ngTouch'
    'ngAnimate'
    'angular-loading-bar'
    'angucomplete-alt'
    'cgBusy'

  ])

###*
 # Configure App
###
githubIssuesApp.config (

  $routeProvider
  $locationProvider
  $localForageProvider
  cfpLoadingBarProvider

  ) ->

  # Disable loading bar spinner
  cfpLoadingBarProvider.includeSpinner = no

  # Enable html5mode (no url hashbangs)
  $locationProvider.html5Mode yes

  # Route config for all issue summary paths
  issuesMainCnf =
    templateUrl: '/views/issues.main.html'
    controller: 'IssuesCtrl'
    reloadOnSearch: no

  #################################
   #  Configure Angular Router
  #################################
  $routeProvider

    # Home
    .when '/',
      templateUrl: '/views/home.html'

    # Issues Summary. Signed in home
    .when '/issues', issuesMainCnf

    # Issues Summary for user
    .when '/user/issues', issuesMainCnf

    # Issues Summary for specific repo
    .when '/repos/:owner/:repo/issues', issuesMainCnf

    # Issues Summary for org
    .when '/orgs/:org/issues', issuesMainCnf

    # Single issue
    .when '/repos/:owner/:repo/issues/:number', issuesMainCnf

    # Error (404), but error is a bit for app-like
    .when '/error',
      templateUrl: '/views/error.html'

    # Redirect any unfound requests to /error
    .otherwise redirectTo: '/error'


  #################################
   #  Configure LocalForage
  #################################
  $localForageProvider.config
    driver: 'localStorageWrapper'
    name: 'github_issues'
    storeName: 'ghi'


###*
 # Initialise scripts etc
###
githubIssuesApp.run ($rootScope, $location, oauth) ->

  #####################################################
  #               Auth Routing
  #####################################################

  ###
   # Take app to the main issues url if signed in
   # and on homepage.
   # Also applies scope if not already in progress
  ###
  gotoIssues = ->
      if $location.path() is '/' and oauth.isSignedIn()
        $location.path '/issues'
        do $rootScope.$apply unless $rootScope.$$phase

  # Prevent / when signed in. /issues become home
  $rootScope.$on '$locationChangeSuccess', gotoIssues

  # Make sure homepage is redirected to /issues when signing in
  $rootScope.$on 'oauth_signin', gotoIssues

  # Go home when signing out
  $rootScope.$on 'oauth_signout', -> $location.path '/'

  #####################################################

  # # jQuery DOM ready
  # $ ->
  #   # Toggle all tooltips
  #   do $('.init-tooltip').tooltip

