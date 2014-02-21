# encoding: UTF-8
class Permission < ActiveRecord::Base

  # Relationships
  belongs_to                    :book_status
  belongs_to                    :profile

  # Specify fields that can be accessible through mass assignment
  attr_accessible               :book_status, :profile, :read, :write, :execute, :review, :git

  accepts_nested_attributes_for :book_status, :profile

  def self.create_for_profile profile
    BookStatus.all.each do |bs|
      p = Permission.new
      p.book_status = bs
      p.profile = profile
      #TO-REFACTOR
      p.read = false
      p.write = false
      p.execute = false
      p.review = false
      p.git = false
      p.save
    end
  end

  def self.create_for_book_status book_status
    Profile.all.each do |pr|
      p = Permission.new
      p.book_status = book_status
      p.profile = pr
      #TO-REFACTOR
      p.read = false
      p.write = false
      p.execute = false
      p.review = false
      p.git = false
      p.save
    end
  end

  def self.get_permissions_for book_status_id, user_profile_id
    Permission.where(:profile_id => user_profile_id, :book_status_id => book_status_id).first
  end
  
end
