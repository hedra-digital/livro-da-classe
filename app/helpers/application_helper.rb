module ApplicationHelper

def full_text(book)
	a = String.new
	book.texts.each do |text|
		a << "\\chapter{#{text.title}}\n#{k_to_latex(text.content)}\n"
	end
	a
end

def k_to_latex(text)
	return Kramdown::Document.new(text).to_latex
end

def lesc(text)
	LatexToPdf.escape_latex(text)
end

end