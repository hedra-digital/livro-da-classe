# Rule Model
class Rule < ActiveRecord::Base
  attr_accessible :label, :command

  validates                 :label,     presence: true, length: { maximum: 30 }
  validates                 :command,   presence: true
end
