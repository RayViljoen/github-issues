'use strict'

describe 'Controller: IssuesCtrl', ->

  # load the controller's module
  beforeEach module 'githubIssuesApp'

  IssuesCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    IssuesCtrl = $controller 'IssuesCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
