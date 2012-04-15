# Chute Integration for Rails apps
        [ wip ]

## Installation
1. Add `gem 'chute', :path => 'GEM_LOCATION'` to Gemfile
2. `bundle install`
3. `rails generate chute:install`
4. `rake db:migrate`

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
