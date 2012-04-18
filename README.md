# Chute Integration for Rails apps
        [ wip ]

## Installation
1. `git clone git@github.com:chute/chute-rails.git`
2. Add `gem 'chute', :path => 'GEM_DIR'` to Gemfile
3. `bundle install`
4. `rails generate chute:install`
5. `rake db:migrate`
6. Edit `config/initializers/chute.rb` with API credentials.
7. Start `rails server`

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
