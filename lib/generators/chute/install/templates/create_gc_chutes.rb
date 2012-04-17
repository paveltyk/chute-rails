class CreateGcChutes < ActiveRecord::Migration
  def self.up
    create_table :gc_chutes do |t|
      # chute info
      t.integer :id
      t.integer :remote_id
      t.string  :name
      t.string  :shortcut
      t.string  :url

      # association info
      t.integer :attachable_id
      t.string  :attachable_type
      t.string  :chute_type

      t.timestamps
    end
  end

  def self.down
    drop_table :gc_chutes
  end
end
