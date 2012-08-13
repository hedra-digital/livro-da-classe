module ApplicationHelper

def to_label
	"<em>#{title}</em>"
end

def kramdown(text)
	return Kramdown::Document.new(text).to_latex
end

def lesc(text)
	LatexToPdf.escape_latex(text)
end

end