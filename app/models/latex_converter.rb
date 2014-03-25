class LatexConverter

  def self.to_latex content
    require "#{Rails.root}/lib/markup_latex.rb"

    return "" if content.nil?

    content = content.gsub(/ <\/(.*?)>/m, '</\1>&nbsp;')
    content = content.gsub(/<([a-z]+)> /m, '&nbsp;<\1>')

    content = "#{MarkupLatex.new(content).to_latex}".html_safe

    content = content.gsub("\n\\\\","\\\\\\\n") #para tabelas
    content = content.gsub("\\textsuperscript{}","") #para footnote
    content = content.gsub("\n\\footnote","\\footnote") #para footnote
    content = content.gsub("\n.\\footnote",".\\footnote") #para footnote

    content = content.gsub("$$$&", "\\\\&")

    content = content.gsub("\\textbar{}\\textgreater{}\\textbar{}", "")
    content = content.gsub("\\textbar{}\\textless{}\\textbar{}", "")

    content = content.gsub("#\\","\\") #para versos

    Expression.where(:level => 3).each do |exp|
      content = content.gsub(eval(exp.target), exp.replace)
    end

    content
  end
end