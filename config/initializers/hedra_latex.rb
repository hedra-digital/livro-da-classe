require "#{Rails.root}/lib/hedra-latex.rb"

latex_template_path = CONFIG[Rails.env.to_sym]["latex_template_path"] << "*"
LATEX_TEMPLATES = Dir.glob(latex_template_path).sort.select { |f| File.directory? f }.map { |m| m.scan(/(?<=\/)\S+$/).first }
