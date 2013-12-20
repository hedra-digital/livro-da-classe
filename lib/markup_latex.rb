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
    content_text = prepare_image content_text
    content_text = prepare_footnote content_text
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
        element[1] = PandocRuby.convert(element[1], {:from => :html, :to => :latex}, :chapters)
        #element[1] = HedraLatex.convert(Kramdown::Document.new(element[1], :input => 'html').root)[0]
      elsif element[0] == :latex
        element[1] = ActionView::Base.full_sanitizer.sanitize(element[1])
      end
    end
  end

  def prepare_text(text)
    l_begin = "|>|"
    l_end = "|<|"
    start_index = 0
    array_text = []

    while !text.empty?
      start_latex = text.index(l_begin)
      if(start_latex.nil?)
        array_text << [:html, text[(start_index)..(text.size - 1)]]
        text[start_index..text.size - 1] = ""
      else
        end_latex = text.index(l_end)
        array_text << [:html, text[(start_index)..(start_latex - 1)]] if (start_latex -1) >= start_index
        array_text << [:latex, text[(start_latex + l_begin.size)..(end_latex - 1)]]
        text[(start_index)..(end_latex + l_end.size - 1)] = ""
      end 
    end
    array_text
  end

  def prepare_image(text)
    while text.match /<img .*? \/>/
      img_tag = text.match /<img .*? \/>/ 

      img_type = get_image_type(img_tag.to_s)

      if img_type != 'imagemlatex'
        img_sub = get_image_sub(img_tag.to_s)
        img_src = get_image_src(img_tag.to_s)
        latex_img = "|>|\\#{img_type}{#{img_sub}}{#{img_src}}|<|" 
      else
        img_sub = get_image_sub(img_tag.to_s)
        latex_img = "|>|\\ $ #{img_sub} $ |<|"
      end

      text = text.sub(img_tag.to_s, latex_img)
    end
    text
  end

  def prepare_footnote(text)
    while text.match /<a class=\"sdfootnoteanc\"(.*?)<\/a>/
      footnote_tag = text.match /<a class=\"sdfootnoteanc\"(.*?)<\/a>/

      footid = footnote_tag.to_s.split("name=\"sdfootnote").last
      footid = footid.split("anc").first

      text_tag = text.match /<div id(.*)sdfootnote#{footid}([[:ascii:]]*?)<\/div>/

      foottext = text_tag.to_s.split("</a>").last
      foottext = foottext.split("</p>").first

      text = text.sub(footnote_tag.to_s, "|>|\\footnote{#{foottext}}|<|")

      text = text.sub(text_tag.to_s, "")
    end
    text
  end

  def get_image_type(img_tag)
    if img_tag.include? "latex-plugin"
      'imagemlatex'
    elsif img_tag.include? "small-intention"
      'imagempequena'
    elsif img_tag.include? "medium-intention"
      'imagemmedia'
    else
      'imagemgrande'
    end
  end

  def get_image_sub(img_tag)
    sub = img_tag[/img.*?alt="(.*?)"/i,1]
    if sub.nil?
      ""
    else
      sub
    end
  end

  def get_image_src(img_tag)
    src = img_tag[/img.*?src="(.*?)"/i,1]
    if src.nil?
      return ""
    else
      return "#{Rails.public_path}#{src}"
    end
  end

end