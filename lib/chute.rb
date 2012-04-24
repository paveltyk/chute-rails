require 'chute/version'
require 'chute/chute_object'
require 'chute/upload'
require 'chute/s3_upload'
require 'chute/parcel'
require 'chute/asset'
require 'chute/chute'
require 'chute/user'

module Chute
  mattr_accessor :app_id
  mattr_accessor :authorization
  mattr_accessor :api_endpoint
  mattr_accessor :user_model

  class << self
    def configure
      yield self
      Chute.user_model.send(:include, Chute::UserCreation) if Chute.user_model
    end

    def is_user_model?(owner)
      Chute.user_model.respond_to?(:name) && Chute.user_model.name == owner.class.name
    end

    def as_chute_user(owner)
      if is_user_model?(owner)
        chute_user = Chute::GCUser.find_by_user_id(owner.id) || Chute::GCUser.create(user: owner)
        Thread.current['chute_authorization'] = chute_user.chute_access_token
      end
      data = nil

      if block_given?
        data = yield
        Thread.current['chute_authorization'] = nil
      end

      data
    end

    def _authorization
      "OAuth " + (Thread.current['chute_authorization'].blank? ? Chute.authorization : Thread.current['chute_authorization'])
    end

    def _app_id
      Thread.current['chute_app_id'].blank? ? Chute.app_id : Thread.current['chute_app_id']
    end
  end
end

require 'chute/request'
require 'chute/connection'
require 'chute/response'
require 'chute/railtie'
