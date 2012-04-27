class FixDateForJobs < ActiveRecord::Migration
  def self.up
	remove_column :jobs, :s_date
        remove_column :jobs, :e_date
        add_column :jobs, :s_date, :datetime
	add_column :jobs, :e_date, :datetime
  end

  def self.down
	remove_column :jobs, :s_date
	remove_column :jobs, :e_date
  end
end
