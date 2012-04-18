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

    def is_user_owned?(owner)
      Chute.user_model.respond_to?(:name) && owner.class.name == Chute.user_model.name
    end

    def as_chute_user(user)
      Thread.current['chute_authorization'] = Chute::GCUser.find_by_user_id(user.id).chute_access_token if is_user_owned?(user)
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
