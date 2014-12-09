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
```
#gem RailsBook
gem 'railsbook', github: 'bukk530/railsbook'```

Save your Gemfile and run:
```
bundle install```

Now that you have installed RailsBook you need to configure your Facebook App!

Do:
```
rails g rails_book:config```
to generate a ```config/facebook_app.yml``` configuration file.

Open config/facebook_app.yml, it should look like this:
```app_id: "YOUR APP ID"
app_secret: "YOUR SECRET"```
Now go to your [Facebook application](https://developers.facebook.com/apps/) and replace the App Id and Secret in your config file

Now you should be able to play with the SDK! 

