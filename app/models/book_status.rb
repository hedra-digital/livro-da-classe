class BookStatus < ActiveRecord::Base
  attr_accessible :desc

  validates :desc,              :presence => true

  def self.default
    if BookStatus.all.size == 0
      b = BookStatus.new
      b.desc = "Em fila"
      b.save
    end
    BookStatus.all.first
  end
end