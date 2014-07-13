'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:issue
 # @description
 # # issue
###
angular.module('githubIssuesApp')
  .directive 'issue', ->

    templateUrl: '/views/directive_templates/issue.html'
    restrict: 'E'
    # link: (scope, element, attrs) ->
    #   element.text 'this is the issue directive'
