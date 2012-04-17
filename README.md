# Chute Integration for Rails apps
        [ wip ]

## Installation
1. `git clone git@github.com:chute/chute-ruby.git`
2. `cd chute-ruby`
3. `git checkout -b upgrade origin/upgrade`
4. Add `gem 'chute', :path => 'GEM_DIR'` to Gemfile
5. `bundle install`
6. `rails generate chute:install`
7. `rake db:migrate`
8. Edit `config/initializers/chute.rb` with API credentials.
9. Start rails server

## Usage
### This gem provides the following association methods on your ActiveRecord models
     1. has_asset
     2. has_chute
     3. has_chute_collection

     class User < ActiveRecord::Base
       has_asset :avatar_image

       has_chute :profile_photos
       has_chute_collection :albums
     end
