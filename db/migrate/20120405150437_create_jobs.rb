class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :s_year
      t.integer :s_month
      t.integer :s_day
      t.time :s_date
      t.integer :e_year
      t.integer :e_month
      t.integer :e_day
      t.time :e_date
      t.integer :current_job
      t.string :city
      t.string :country
      t.string :state_us
      t.string :institution
      t.string :department
      t.string :position
      t.string :content
      t.string :job_type #text
      t.integer :user_id

      t.timestamps
    end
    add_index :jobs, [:user_id, :s_date]
    add_index :jobs, [:user_id, :e_date]
  end

  def self.down
    drop_table :jobs
  end
end
