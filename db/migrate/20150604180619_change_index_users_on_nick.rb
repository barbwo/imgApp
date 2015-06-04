class ChangeNickOptionsForUser < ActiveRecord::Migration
  
  def self.up
    remove_index :users, :nick
    add_index :users, :nick
  end
  
  def self.down
    remove_index :users, :nick
    add_index :users, :nick, unique: true
  end
end
