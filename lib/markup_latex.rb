class MarkupLatex

  require "#{Rails.root}/lib/hedra-latex.rb"

  def initialize(text)
    @text  = text    
  end
  
  def to_latex
    build_string_from_array build_array decode @text.dup
  end

  private

  def build_string_from_array(compiled_array)
    string = ""
    compiled_array.each{|a| string << a[1]}
    string
  end

  def build_array(content_text)
    array = prepare_text content_text
    compiled_array = compile_latex array
  end

  def decode(content_text)
    coder ||= HTMLEntities.new
    coder.decode(content_text)
  end
  
  def compile_latex(array)
    array.each do |element|
      if element[0] == :html
        element[1] = HedraLatex.convert(Kramdown::Document.new(element[1], :input => 'html').root)[0]
      elsif element[0] == :latex
        element[1] = ActionView::Base.full_sanitizer.sanitize(element[1])
        #removing html tags of latex code
      end
    end
  end

  def prepare_text(text)
    l_begin = "{beginlatex}"
    l_end = "{endlatex}"
    start_index = 0
    array_text = []

    while !text.empty?
      start_latex = text.index(l_begin)
      if(start_latex.nil?)
        array_text << [:html, text[(start_index)..(text.size - 1)]]
        text[start_index..text.size - 1] = ""
      else
        end_latex = text.index(l_end)
        array_text << [:html, text[(start_index)..(start_latex - 1)]]
        array_text << [:latex, text[(start_latex + l_begin.size)..(end_latex - 1)]]
        text[(start_index)..(end_latex + l_end.size - 1)] = ""
      end 
    end
    array_text
  end
end