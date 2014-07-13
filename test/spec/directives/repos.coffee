'use strict'

describe 'Directive: repos', ->

  # load the directive's module
  beforeEach module 'githubIssuesApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<repos></repos>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the repos directive'
