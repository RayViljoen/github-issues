'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:repos
 # @description
 # # repos
###
angular.module('githubIssuesApp')
  .directive 'repos', ->

    template: '<div id="repos_filter"></div>'
    restrict: 'E'
    controller: ($scope, $element, github) ->

      # github.getCached '/user/orgs', per_page: 100
      #  .then (res) ->
      #   github.get "/orgs/#{res.data[0].login}/repos", per_page: 100
      #     .then (res) -> console.log res

    # link: (scope, element, attrs) ->
    #   element.text 'this is the repos directive'
