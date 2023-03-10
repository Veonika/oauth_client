<h1>OAUTHCLIENT</h1>

This gem provides plugins (apple, google, odnoklassniki, vkontakte) for user authentication validation.

<h2>Installation</h2>

Add this line to your application's Gemfile:

```
gem 'oauth_client'
```

And then execute:

```
$ bundle
```

Or install it yourself: 

```
$ gem install 'oauth_client'
```

<h2>Usage</h2>

In file config/initializers/oauth_client.rb mention plugins you want to use:

```
require 'oauth_client'

OauthClient.plugin :vkontakte
OauthClient.plugin :google
OauthClient.plugin :apple
OauthClient.plugin :odnoklassniki, { key: *odnoklassniki-private-key* } # with additional options
```

For these plugins use method .register to get user data from mentioned social network:

```
OauthClient::Plugins::Google.register(access_token: *access_token*)
```

If access_token is invalid, method returns error with status code 403.

