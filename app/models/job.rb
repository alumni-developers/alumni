# == Schema Information
#
# Table name: jobs
#
#  id          :integer         not null, primary key
#  s_year      :integer
#  s_month     :integer
#  s_day       :integer
#  e_year      :integer
#  e_month     :integer
#  e_day       :integer
#  current_job :integer
#  city        :string(255)
#  country     :string(255)
#  state_us    :string(255)
#  institution :string(255)
#  department  :string(255)
#  position    :string(255)
#  job_type    :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  s_date      :datetime
#  e_date      :datetime
#  content     :text
#

class Job < ActiveRecord::Base
   attr_accessible :s_year, :s_month, :s_day, :s_date, :e_year, :e_month, :e_day, :e_date, :current_job, :city, :country, :state_us, :institution, :department, :position, :content, :job_type
   
   belongs_to :user
   
   before_save :compute_dates
   
   default_scope :order => 'jobs.s_date DESC'

   private
   def compute_dates
       self.s_date=Time.utc(s_year,s_month,s_day)
       self.e_date=Time.utc(e_year,e_month,e_day)
   end

end
