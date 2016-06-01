# Rule Model
class Rule < ActiveRecord::Base
  attr_accessible :label, :command
  has_and_belongs_to_many :books

  validates                 :label,     presence: true, length: { maximum: 30 }
  validates                 :command,   presence: true
end
