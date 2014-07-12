'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:issue
 # @description
 # # issue
###
angular.module('githubIssuesApp')
  .directive 'issue', ->

    template: '<div>TEMPLATE CONTENT</div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the issue directive'
