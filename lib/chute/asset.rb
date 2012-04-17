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

    validates :file, :presence => { :message => "No file specified for asset." }

    attr_accessor :file

    before_create :upload_asset

    def initialize(attributes = {})
      super(attributes)
    end

    def save(validation = true)
      super(validation)
    end

    private

    def upload_asset
      file_details = details_for(file)
      chute = '3t0Txolm'

      parcel = Parcels.create({files: JSON.unparse([file_details]), chutes: JSON.unparse([chute])})
      token  = Uploads.generate_token(parcel.first.asset_id)
      S3Upload.new(token).upload
      asset = Uploads.complete(parcel.first.asset_id)
      set_attributes(asset)
    end

    def details_for(file)
      { filename: file.tempfile.path,
        md5:      file.tempfile.size,
        size:     file.tempfile.size }
    end

    def set_attributes(asset)
      %w{url source_url is_portrait is_published}.each do |attribute|
        send("#{attribute}=", asset.send(attribute))
      end
      self.remote_id = asset.id
    end
  end

  class Assets < ChuteObject
    class << self
      def get(id)
        Request.get("/assets/#{id}")
      end

      def remove(id)
        Request.delete("/assets/#{id}")
      end

      def remove_assets(asset_ids)
        Request.post("/assets/remove", { asset_ids: asset_ids })
      end
    end
  end
end
