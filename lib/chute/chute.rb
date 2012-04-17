module Chute
  module ClassMethods

    def has_chute(name, options = {})
      has_one name.to_sym,  :class_name => "Chute::GCChute",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:chute_type => name.to_s.singularize.camelize}
    end

    def has_chute_collection(name, options = {})
      has_many name.to_sym, :class_name => "Chute::GCChute",
                            :as => :attachable,
                            :dependent => :destroy,
                            :conditions => {:chute_type => name.to_s.singularize.camelize}
    end

  end

  class GCChute < ActiveRecord::Base
    belongs_to :attachable, :polymorphic => true
    validates :chute_type, :presence => { :message => "This is a superclass." }

    validates :name, :presence => { :message => "Name is required." }

    before_create :create_chute

    def initialize(attributes = {})
      super(attributes)
    end

    def save(validation = true)
      super(validation)
    end

    private

    def create_chute
      chute = Chutes.create({chute: {name: name}})
      set_attributes(chute)
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
