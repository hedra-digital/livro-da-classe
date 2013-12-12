# encoding: UTF-8
class Permission < ActiveRecord::Base

  # Relationships
  belongs_to                    :book_status
  belongs_to                    :profile

  # Specify fields that can be accessible through mass assignment
  attr_accessible               :book_status, :profile, :read, :write, :execute

  accepts_nested_attributes_for :book_status, :profile

  def self.create_for_profile profile
    BookStatus.all.each do |bs|
      p = Permission.new
      p.book_status = bs
      p.profile = profile
      p.read = false
      p.write = false
      p.execute = false
      p.save
    end
  end

  def self.create_for_book_status book_status
    Profile.all.each do |pr|
      p = Permission.new
      p.book_status = book_status
      p.profile = pr
      p.read = false
      p.write = false
      p.execute = false
      p.save
    end
  end
  
end
