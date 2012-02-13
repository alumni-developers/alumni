class MoreInformationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :linkedin, :string
	  add_column :users, :abroad, :text
	  add_column :users, :work, :text
  end

  def self.down
    remove_column :users, :linkedin, :string
    remove_column :users, :abroad, :text
    remove_column :users, :work, :text
  end
end

