# encoding: UTF-8

# == Schema Information
#
# Table name: projects
#
#  id                       :integer          not null, primary key
#  book_id                  :integer
#  release_date             :date
#  finish_date              :date
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  client_id                :integer
#  school_logo_file_name    :string(255)
#  school_logo_content_type :string(255)
#  school_logo_file_size    :integer
#  school_logo_updated_at   :datetime
#

class Project < ActiveRecord::Base

  MANUFACTURE_IN_UNITS = 25
  MANUFACTURE_TIME     = MANUFACTURE_IN_UNITS.send(:days)

  # Relationships
  belongs_to                    :book
  belongs_to                    :client

  # Validations
  validates_numericality_of     :quantity, :greater_than => 99
  validates                     :book_id, :presence => true
  validates                     :terms_of_service, :acceptance => true
  validates_with                ProjectValidator

  # Specify fields that can be accessible through mass assignment
  attr_accessible               :book_id, :release_date, :client_attributes, :client, :terms_of_service, :book, :book_attributes, :school_logo, :publish_format, :quantity

  accepts_nested_attributes_for :client, :book

  has_attached_file             :school_logo

  PUBLISH_FORMAT_PRICE = {
    "21 x 14 cm" => 0.4,
    "14 x 21 cm" => 0.2,
    "16 x 23 cm" => 0.23
  }

  def has_valid_release_date?
    self.release_date.present? && (self.release_date > (Date.today + Project::MANUFACTURE_TIME))
  end

  def finish_date
    if has_valid_release_date?
      self.release_date - Project::MANUFACTURE_TIME
    else
      return nil
    end
  end

  def remaining_days
    return nil unless (self.release_date && self.finish_date)
    days = (self.finish_date - Date.today).to_i
    days >= 0 ? days : 0
  end

  def calculated_pages
    self.book.count_pages
  end

  def price
    if !self.calculated_pages.nil?
      price = self.calculated_pages * PUBLISH_FORMAT_PRICE[self.publish_format]
      price = "%0.2f" % price
      "R$ #{price}"
    else
      "Preço unitário não calculado"
    end
  end

  def total_price
    if !self.calculated_pages.nil? and !self.quantity.nil?
      total = self.calculated_pages * PUBLISH_FORMAT_PRICE[self.publish_format] * self.quantity
      total = "%0.2f" % total
      "R$ #{total}"
    else
      "Preço total não calculado"
    end
  end

end
