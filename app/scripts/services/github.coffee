'use strict'

###*
 # @ngdoc service
 # @name githubIssuesApp.github
 # @description
 # # github
 # Factory in the githubIssuesApp.
###
angular.module('githubIssuesApp')
  .factory 'github', ->
    # Service logic
    # ...

    meaningOfLife = 42

    # Public API here
    {
      someMethod: ->
        meaningOfLife
    }
