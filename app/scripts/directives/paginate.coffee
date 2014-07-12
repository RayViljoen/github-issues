'use strict'

###*
 # @ngdoc directive
 # @name githubIssuesApp.directive:paginate
 # @description
 # # paginate
###
angular.module('githubIssuesApp')
  .directive 'paginate', ->

    template: '<div></div>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      element.text 'this is the paginate directive'


