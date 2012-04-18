class CreateGcUsers < ActiveRecord::Migration
  def self.up
    create_table :gc_users do |t|
      # user info
      t.integer :id
      t.integer :user_id , :unique => true
      t.integer :chute_remote_id
      t.string  :chute_access_token

      t.timestamps
    end
  end

  def self.down
    drop_table :gc_users
  end
end
