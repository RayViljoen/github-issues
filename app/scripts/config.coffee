'use strict'

###*
 # @ngdoc function
 # @name githubIssuesApp.constants
 # @description
 # # githubIssuesApp Config
###
angular.module('config', [])

  # App Title
  .constant 'TITLE', 'GitHub Issues'

  # Set GitHub App Client ID - https://github.com/settings/applications/
  .constant 'OAUTH_CLIENT_ID', 'kCXXgmrzGG-b01dKwgMryrQP-zs'
