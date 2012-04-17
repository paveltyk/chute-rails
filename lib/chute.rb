require 'chute/version'
require 'chute/chute_object'
require 'chute/upload'
require 'chute/s3_upload'
require 'chute/parcel'
require 'chute/asset'
require 'chute/chute'
require 'chute/railtie'

module Chute
  module ClassMethods
    def as_chute_user(entity)
      return 'not implemented'
      Thread.current['chute_authorization'] = Chute::GCEntity.find_entity(entity).auth_token
      data = nil

      if block_given?
        data = yield
        Thread.current['chute_authorization'] = nil
      end

      data
    end
  end

  mattr_accessor :app_id
  mattr_accessor :authorization
  mattr_accessor :api_endpoint

  class << self
    def configure
      yield self
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
