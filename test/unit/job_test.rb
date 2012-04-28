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

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
