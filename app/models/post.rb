class Post < ActiveRecord::Base
  attr_accessible :content, :title

  belongs_to :user

  validates :title,   :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  default_scope order('created_at DESC')
end

# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)
#

