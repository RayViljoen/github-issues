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
    controller: ($scope, $element, github) ->
      # github.get '/user/orgs'
      #  .then (res) -> console.log res
    link: (scope, element, attrs) ->
      element.text 'this is the orgs directive'
  )
