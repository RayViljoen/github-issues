'use strict'

describe 'Service: oauth', ->

  # load the service's module
  beforeEach module 'githubIssuesApp'

  # instantiate service
  oauth = {}
  beforeEach inject (_oauth_) ->
    oauth = _oauth_

  it 'should do something', ->
    expect(!!oauth).toBe true
