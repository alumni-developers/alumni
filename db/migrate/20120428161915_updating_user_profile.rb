class UpdatingUserProfile < ActiveRecord::Migration
  def self.up
  remove_column :users, :abroad
  remove_column :users, :work
  add_column :users, :blog, :string
  add_column :users, :age, :integer
  add_column :users, :telephone, :string
  add_column :users, :procedence, :string
  add_column :users, :current_location, :string
  end

  def self.down
  add_column :users, :abroad
  add_column :users, :work
  remove_column :users, :blog, :string
  remove_column :users, :age, :integer
  remove_column :users, :telephone, :string
  remove_column :users, :procedence, :string
  remove_column :users, :current_location, :string
  end
end
