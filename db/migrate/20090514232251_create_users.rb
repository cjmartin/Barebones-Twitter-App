class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :twitter_id
      t.string  :twitter_token
      t.string  :twitter_secret
      t.string  :persistence_token, :null => false

      t.timestamps
    end
    add_index :users, :twitter_id, :unique => true
  end

  def self.down
    drop_table :users
  end
end
