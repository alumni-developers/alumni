class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
	add_column :users, :degree, :string
	add_column :users, :year, :integer
	add_column :users, :likes, :text
  end

  def self.down
	remove_column :users, :degree, :string
    remove_column :users, :year, :integer
    remove_column :users, :likes, :text
  end
end
