module Chute
  class Railtie < Rails::Railtie
    initializer 'get_chute_api.ar_extensions' do |app|
      ActiveRecord::Base.extend ClassMethods
    end
  end
end