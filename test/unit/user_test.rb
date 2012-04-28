# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  degree1            :string(255)
#  year               :integer
#  likes              :text
#  linkedin           :string(255)
#  admin              :boolean         default(FALSE)
#  degree2            :string(255)
#  blog               :string(255)
#  age                :integer
#  telephone          :string(255)
#  procedence         :string(255)
#  current_location   :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

