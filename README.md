Railsbook - Facebook SDK for Rails4!
====================================

Introduction
------------
This SDK is based on the offical [Facebook PHP SDK](https://github.com/facebook/facebook-php-sdk-v4)

Usage
-----

Configuration
-------------

To start using this gem you need to include it in your Rails4 app Gemfile:
```ruby
#gem RailsBook
gem 'railsbook', github: 'bukk530/railsbook'
```

Save your Gemfile and run:
```bash
bundle install
```

Now that you have installed RailsBook you need to configure your Facebook App!

Do:
```bash
rails g rails_book:config
```
to generate a ```config/facebook_app.yml``` configuration file.

Open config/facebook_app.yml, it should look like this:
```YML
app_id: "YOUR APP ID"
app_secret: "YOUR SECRET"
```

Now go to your [Facebook application](https://developers.facebook.com/apps/) and replace the App Id and Secret in your config file

If you use Git, do:
```bash
git add config/initializers/facebook.rb
git add config/facebook_app.yml
```
 
Now you should be able to play with the SDK! 

Usage
-----

Ok let's start with a simple login page:

routes.rb
```ruby
Rails.application.routes.draw do
  root				   "fb_login_controller#show_login"
  get "/login",    to: "fb_login_controller#login",        as: :login
end
```

fb_login_controller.rb
```ruby
class FbLoginController < ApplicationController
	
	# Initialize our helper (in a future version this will be a real rails helper)
	before_action do
		@facebook_login_helper = FacebookRedirectLoginHelper.new login_url, session, params
	end
	
	# In this page we will ask the user to log in via Facebook
	def show_login
		@facebook_login_url = @facebook_login_helper.get_login_url
	end
	
	# This page is called back from Facebook after the user logged in
	def login
	  facebook_session = @facebook_login_helper.get_session_from_redirect
	  @user = FacebookRequest.new(facebook_session, 'GET', '/me').execute.response
	end
end
```

show_login.html.erb
```ruby
<a href="<%= @facebook_login_url %>">Login via Facebook!</a>
```

login.html.erb
```ruby
<h1>Halo <%= @user['name'] %></h1>
```

