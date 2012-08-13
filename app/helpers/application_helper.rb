module ApplicationHelper

def kramdown(text)
	return Kramdown::Document.new(text).to_latex
end

def lesc(text)
	LatexToPdf.escape_latex(text)
end

end