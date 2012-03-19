class AddTwoDegreeFields < ActiveRecord::Migration
  def self.up
    add_column :users, :degree2, :string
    rename_column :users, :degree, :degree1
  end

  def self.down
    remove_column :users, :degree2
    rename_column :users, :degree1, :degree
  end
end
