module KramdownHelper

	def kramdown(text)
		return Kramdown::Document.new(text).to_latex
	end

end