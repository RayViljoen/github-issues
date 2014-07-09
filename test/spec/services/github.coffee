'use strict'

describe 'Service: github', ->

  # load the service's module
  beforeEach module 'githubIssuesApp'

  # instantiate service
  github = {}
  beforeEach inject (_github_) ->
    github = _github_

  it 'should do something', ->
    expect(!!github).toBe true
