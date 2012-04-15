module Chute
  module ClassMethods

    def has_asset(name, options = {})
      has_one name.to_sym,  :class_name => "Chute::GCAsset",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:asset_type => name.to_s.singularize.camelize}

      define_method "#{name}=" do |file|
        self.send("build_#{name}", file: file)
      end
    end

  end

  class GCAsset < ActiveRecord::Base
    belongs_to :attachable, :polymorphic => true
    validates :asset_type, :presence => { :message => "This is a superclass." }

    attr_accessor :file

    def initialize(attributes = {})
      super(attributes)
    end

    def save(arg = true)
      super(arg)
    end
  end
end
