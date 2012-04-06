class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :s_year
      t.integer :s_month
      t.integer :s_day
      t.integer :e_year
      t.integer :e_month
      t.integer :e_day
      t.string :city
      t.string :country
      t.string :state_us
      t.string :institution
      t.string :department
      t.string :position
      t.string :content
      t.string :type
      t.integer :user_id

      t.timestamps
    end
    add_index :jobs, [:user_id, :s_year, :s_month, :s_day]
  end

  def self.down
    drop_table :jobs
  end
end
