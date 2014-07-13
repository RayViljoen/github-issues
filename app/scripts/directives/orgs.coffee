'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:orgs
 # @description
 # # orgs
###
angular.module('githubIssuesApp')
  .directive('orgs', ->
    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the orgs directive'
  )
