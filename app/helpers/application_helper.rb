module ApplicationHelper

def full_text(book)
	@book.texts.each do |text|
		"\chapter{#{text.title}"
		kramdown text.content
	end
end

def kramdown(text)
	return Kramdown::Document.new(text).to_latex
end

def lesc(text)
	LatexToPdf.escape_latex(text)
end

end