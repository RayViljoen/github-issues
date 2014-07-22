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
    scope: { repo: '=', owner: '=' }

    # Repo Directive Controller
    controller: ($scope, $location, github) ->

      # If repo isn't set then watch for it's update
      # to set the new path
      unless $scope.repo then $scope.$watch 'repo', ->

        # Avoid initial watch trigger as repo isn't set yet
        return unless $scope.repo

        # Get route params
        owner = $scope.repo.originalObject.owner.login
        name = $scope.repo.originalObject.name

        # Set new url
        $location.path "/repos/#{owner}/#{name}/issues"


      # Loads repos
      $scope.load = (refresh=no) ->

        # Start loading animation
        $scope.loading = yes

        # Get repos
        github.getRepos(refresh).then (repos) ->

          # Apply repos
          $scope.repos = repos

          # Stop animation
          $scope.loading = no


      # Load repos on ctrl init if repo isn't set
      do $scope.load unless $scope.repo

