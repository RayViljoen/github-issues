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
    scope: { repo: '=ngModel' }

    # Repo Directive Controller
    controller: ($scope, github) ->

      # Fresh set of repos
      do $scope.refresh = (refresh=no) ->

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

        # Clear input text
        $('angucomplete-alt input').val null

        # Unset scope repo
        $scope.repo = ''

