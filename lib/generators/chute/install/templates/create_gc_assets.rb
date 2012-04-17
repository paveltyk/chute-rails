class CreateGcAssets < ActiveRecord::Migration
  def self.up
    create_table :gc_assets do |t|
      # asset info
      t.integer :id
      t.integer :remote_id
      t.string  :url
      t.boolean :is_portrait
      t.boolean :is_published

      # association info
      t.integer :attachable_id
      t.string  :attachable_type
      t.string  :asset_type

      t.timestamps
    end
  end

  def self.down
    drop_table :gc_assets
  end
end
