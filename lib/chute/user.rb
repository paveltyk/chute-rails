module Chute
  module UserCreation
    extend ActiveSupport::Concern

    included do
      after_create :ensure_chute_user
    end

    def ensure_chute_user
      Chute::GCUser.create(user: self)
    end
  end

  class GCUser < ActiveRecord::Base
    before_create :create_chute_user

    attr_accessor :user

    private

    def create_chute_user
      chute_user = Users.create({ id: user.id, email: user.email })
      set_attributes(chute_user)
    end

    def set_attributes(chute_user)
      self.user_id            = user.id
      self.chute_remote_id    = chute_user.id
      self.chute_access_token = chute_user.token
    end
  end

  class Users < ChuteObject
    class << self
      def create(data)
        Request.post("/users", { data: data })
      end
    end
  end
end
