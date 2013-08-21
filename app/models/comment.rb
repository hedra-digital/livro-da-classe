# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  text_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :text_id, :user_id
  belongs_to :text
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true
  validates :text_id, presence: true
end
