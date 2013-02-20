class Comment < ActiveRecord::Base
  attr_accessible :content, :text_id, :user_id
  belongs_to :text
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true
  validates :text_id, presence: true
end
