'use strict'

describe 'Directive: paginate', ->

  # load the directive's module
  beforeEach module 'githubIssuesApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<paginate></paginate>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the paginate directive'
