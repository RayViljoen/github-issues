'use strict'

###*
 # @ngdoc overview
 # @name githubIssuesApp
 # @description
 # # githubIssuesApp
 #
 # Main module of the application.
###
angular.module('githubIssuesApp', [

    'config'
    'ngRoute',
    'ngResource',
    'ngTouch'

  ])

  # Configure App
  .config ($routeProvider, $locationProvider) ->

    # Initialise Foundation
    $(document).foundation();

    # Enable html5mode (no url hashbangs)
    $locationProvider.html5Mode yes

    # Configure Routes
    $routeProvider

      .when '/',

        templateUrl: 'views/main.html'
        controller: 'MainCtrl'

      .when '/about',

        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'

      .otherwise
        redirectTo: '/'

