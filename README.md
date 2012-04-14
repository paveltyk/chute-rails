# Chute Integration for Rails apps
        [ wip ]

## Installation
1. Add `gem 'chute', :path => 'GEM_LOCATION'` to Gemfile
2. `bundle install`
3. `rails generate chute:install`
4. `rake db:migrate`

## Usage
### This gem provides the following association methods on your ActiveRecord models
     1. has_one_asset
     2. has_many_assets
     3. has_one_chute
     4. has_many_chutes
