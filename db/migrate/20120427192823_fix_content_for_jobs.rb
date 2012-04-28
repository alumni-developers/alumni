class FixContentForJobs < ActiveRecord::Migration
  def self.up
	remove_column :jobs, :content
	add_column :jobs, :content, :text
  end

  def self.down
	remove_column :jobs, :content
  end
end
