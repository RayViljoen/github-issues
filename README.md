# GitHub Issues

A 100% client-side app for managing GitHub Issues.

---

Github App: `https://github.com/settings/applications/112864`


#### Install App:

1. Clone Repo

2. run `npm install`

3. run `bower install`

4. Set up configuration file at `/app/scripts/config.coffee`. Most likely only change the OAuth client-id.

5. run `grunt serve` to run locally and serve on port 9000 or run `grunt build` to build the app for production.


#### OAuth

- Handled with [OAuth.io](http://oauth.io/)

- [OAuth.io](http://oauth.io/) account login via GitHub OAuth

### GitHub

**Get all issues:**
`/issues` - https://developer.github.com/v3/issues/#parameters

**Get all comments for issue**
`/repos/:owner/:repo/issues/:number/comments`

