# Rule Model
class Rule < ActiveRecord::Base
  after_save :generate_commands
  attr_accessible :label, :command

  validates                 :label,     presence: true, length: { maximum: 30 }
  validates                 :command,   presence: true

  private

  def generate_commands
    Thread.new do
      logger.info 'Update commands.sty'
      input_commands = ''
      Rule.all.each do |rule|
        if rule.active
          input_commands << "% #{rule.label}\n"
          input_commands << rule.command + "\n\n"
        end
      end
      File.open('public/commands.sty','w') {|io| io.write(input_commands) }
    end
  end
end
