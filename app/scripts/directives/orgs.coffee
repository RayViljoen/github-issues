'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:orgs
 # @description
 # # orgs
###
angular.module('githubIssuesApp')
  .directive 'orgs', ->

    templateUrl: '/views/directive_templates/orgs.html'
    restrict: 'E'

    # Bind selected org to standard ngModel
    scope: { org: '=ngModel' }

    # Org Directive Controller
    controller: ($scope, github) ->

      # Fresh set of orgs
      do $scope.refresh = (refresh=no) ->

        # Start loading animation
        $scope.loading = yes

        # Get orgs
        github.getCached('/user/orgs', refresh)
        .then (orgs) ->
          console.log 'done load'
          # Apply orgs
          $scope.orgs = orgs

          # Stop animation
          $scope.loading = no


      # Called when removing org filter
      $scope.clear = ->

        # Clear input text
        # $('angucomplete-alt input').val null

        # Unset scope org
        $scope.org = ''
