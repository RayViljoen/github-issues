'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:repos
 # @description
 # # repos
###
angular.module('githubIssuesApp')
  .directive 'repos', ->

    templateUrl: '/views/directive_templates/repos.html'
    restrict: 'E'

    # Bind selected repo to standard ngModel
    scope: { repo: '=ngModel', owner: '=' }

    # Repo Directive Controller
    controller: ($scope, github, $interval) ->

      # Get repos
      do $scope.load = (refresh=no) ->

        # Start loading animation
        $scope.loading = yes

        # Get repos
        github.getRepos(refresh).then (repos) ->

          # Apply repos
          $scope.repos = repos

          # Stop animation
          $scope.loading = no


      # Called when removing repo filter
      $scope.clear = ->

        # Unset scope repo
        $scope.repo = ''

