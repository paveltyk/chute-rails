module Chute
  module ClassMethods

    def has_one_chute(name, options = {})
      has_one name.to_sym,  :class_name => "Chute::GCChute",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:chute_type => name.to_s.singularize.camelize}
    end

    def has_many_chutes(name, options = {})
      has_many name.to_sym, :class_name => "Chute::GCChute",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:chute_type => name.to_s.singularize.camelize}
    end

  end

  class GCChute < ActiveRecord::Base
    belongs_to :attachable, :polymorphic => true
    validates :chute_type, :presence => { :message => "This is a superclass." }

    def initialize(attributes = {})
      super(attributes)
    end

    def save(arg = true)
      super(arg)
    end
  end
end
