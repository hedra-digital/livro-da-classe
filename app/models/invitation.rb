class Invitation < ActiveRecord::Base
  attr_accessible :book_id, :invited_id
end
