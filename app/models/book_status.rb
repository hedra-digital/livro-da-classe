class BookStatus < ActiveRecord::Base

  after_commit :create_permissions, :on => :create

  attr_accessible :desc

  validates :desc,              :presence => true

  def self.default
    BookStatus.all.first
  end

  def create_permissions
    Permission.create_for_book_status self
  end
end
