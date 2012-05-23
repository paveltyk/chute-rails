module Chute
  module ClassMethods
    def has_chute(name, options = {})
      has_one name.to_sym,  :class_name => "Chute::GCChute",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:chute_type => name.to_s.singularize.camelize, :name => name.to_s}

      accepts_nested_attributes_for name.to_sym, :allow_destroy => true
    end

    def has_chute_collection(name, options = {})
      has_many name.to_sym, :class_name => "Chute::GCChute",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:chute_type => name.to_s.singularize.camelize}

      accepts_nested_attributes_for name.to_sym, :allow_destroy => true
    end
  end

  class GCChute < ActiveRecord::Base
    belongs_to :attachable, :polymorphic => true
    validates :chute_type, :presence => { :message => "This is a superclass." }

    validates :name, :presence => { :message => "Name is required." }

    before_create :create_chute

    has_many :assets, :class_name => "Chute::GCAsset",
                      :as => :attachable,
                      :dependent => :destroy,
                      :conditions => {:asset_type => 'GCChuteAsset'}

    accepts_nested_attributes_for :assets, :allow_destroy => true

    def is_chute_model?
      true
    end

    def owner
      (self.attachable.respond_to?(:is_chute_model?) && self.attachable.is_chute_model?) ? self.attachable.owner : self.attachable
    end

    private

    def create_chute
      Chute.as_chute_user(self.owner) do
        chute = Chutes.create({name: name})
        set_attributes(chute)
      end
    end

    def set_attributes(chute)
      %w{shortcut url}.each do |attribute|
        send("#{attribute}=", chute.send(attribute))
      end
      self.remote_id = chute.id
    end
  end

  class Chutes < ChuteObject
    class << self
      def all
        Request.get("/me/chutes")
      end

      def create(data)
        Request.post("/chutes", data)
      end

      def find(id)
        Request.get("/chutes/#{id}")
      end

      def delete(id)
        Request.delete("/chutes/#{id}")
      end

      def assets(id, page)
        Request.get("/chutes/#{id}/assets", { page: page })
      end

      def add_assets(id, asset_ids)
        Request.post("/chutes/#{id}/assets/add", { asset_ids: asset_ids })
      end

      def remove_asset(id, asset_id)
        remove_assets(id, [asset_id])
      end

      def remove_assets(id, asset_ids)
        Request.post("/chutes/#{id}/assets/remove", { asset_ids: asset_ids })
      end
    end
  end
end
