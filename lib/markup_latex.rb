class MarkupLatex

  require "#{Rails.root}/lib/hedra-latex.rb"

  def initialize(text)
    @text  = text    
  end
  
  def to_latex
    build_array decode @text.dup
  end

  private

  def build_array(content_text)
    puts "1" * 100
    content_text = prepare_marker content_text
    puts "2" * 100
    content_text = prepare_image content_text
    puts "3" * 100
    content_text = prepare_footnote content_text
    puts "4" * 100
    content_text = prepare_verse content_text
    puts "5" * 100
    content_text = prepare_epigraph content_text
    puts "6" * 100
    content_text = prepare_chapter content_text
    puts "7" * 100
    content_text = prepare_alignment content_text
    puts "8" * 100
    compiled_array = compile_latex(prepare_text content_text)
    puts "9" * 100
    compiled_array
  end

  def decode(content_text)
    coder ||= HTMLEntities.new
    coder.decode(content_text)
  end
  
  def compile_latex(array)
    t = ""
    i = 0
    array.each do |element|
      if element[0] == :html
        t << element[1]
      elsif element[0] == :latex
        t << "{{{{#{i}}}}}" 
      end
      i += i + 1
    end

    t = PandocRuby.convert(t, {:from => :html, :to => :latex}, :chapters)

    i = 0
    array.each do |element|
      if element[0] == :latex
        t = t.gsub("\\{\\{\\{\\{#{i}\\}\\}\\}\\}", ActionView::Base.full_sanitizer.sanitize(element[1]))
      end
      i += i + 1
    end
    t
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
        latex_img = "|>|\\#{img_type}{#{img_sub}}{#{img_src}} |<|" 
      else
        img_sub = get_image_sub(img_tag.to_s)
        latex_img = "|>|\\ $ #{img_sub} $ |<|"
      end

      text = text.sub(img_tag.to_s, latex_img)
    end
    text
  end

  def prepare_footnote(text)
    while text.match /<a(.*?)name=\"sdfootnote(.*?)anc\"(.*?)<\/a>/m
      footnote_tag = text.match /<a(.*?)name=\"sdfootnote(.*?)anc\"(.*?)<\/a>/m

      footid = footnote_tag.to_s.split("name=\"sdfootnote").last
      footid = footid.split("anc").first

      text_tag = text.match /<div id=\"sdfootnote#{footid}(.*?)<\/div>/m

      foottext = text_tag.to_s.split("</a>").last
      foottext = foottext.split("</p>").first

      foottext = PandocRuby.convert(foottext, {:from => :html, :to => :latex}, :chapters)

      foottext = foottext.sub("\\&", "$$$&")

      text = text.sub(footnote_tag.to_s, "|>|\\footnote{#{foottext}} |<|")

      text = text.sub(text_tag.to_s, "")
    end
    text
  end

  def prepare_epigraph(text)
    while text.match /<section class="epigraph">(.*?)<\/section>/m
      epigraph = text.match /<section class="epigraph">(.*?)<\/section>/m

      if epigraph.to_s.match /<span class="epigraph-author">(.*?)<\/span>/m
        epigraph_author = epigraph.to_s.match /<span class="epigraph-author">(.*?)<\/span>/m
        
        epigraph_text = epigraph.to_s.gsub(epigraph_author.to_s, "")
        epigraph_text = compile_latex(prepare_text(epigraph_text))
        epigraph_text = epigraph_text.sub("\\&", "$$$&")
        epigraph_text = epigraph_text.chomp("\n")

        epigraph_author = PandocRuby.convert(epigraph_author, {:from => :html, :to => :latex}, :chapters)
        epigraph_author = epigraph_author.sub("\\&", "$$$&")
        epigraph_author = epigraph_author.chomp("\n")
      else
        epigraph_text = ""
        epigraph_author = ""
      end

      text = text.sub(epigraph.to_s, "|>|\\epigraph{#{epigraph_text}}{#{epigraph_author}} |<|")
    end
    text
  end

  def prepare_chapter(text)
    while text.match /<section class="chapter">(.*?)<\/section>/m
      chapter = text.match /<section class="chapter">(.*?)<\/section>/m

      if chapter.to_s.match /<h1>(.*?)<\/h1>/m
        title = (chapter.to_s.match /<h1>(.*?)<\/h1>/m)[1]
        title = PandocRuby.convert(title.to_s, {:from => :html, :to => :latex}, :chapters)
        title = title.chomp("\n")
      else
        title = ""
      end

      if chapter.to_s.match /<h3>(.*?)<\/h3>/m
        subtitle = (chapter.to_s.match /<h3>(.*?)<\/h3>/m)[1]
        subtitle = PandocRuby.convert(subtitle.to_s, {:from => :html, :to => :latex}, :chapters)
        subtitle = subtitle.chomp("\n")
      else
        subtitle = ""
      end
        
      if chapter.to_s.match /<p>(.*?)<\/p>/m
        author = (chapter.to_s.match /<p>(.*?)<\/p>/m)[1]
        author = PandocRuby.convert(author.to_s, {:from => :html, :to => :latex}, :chapters)
        author = author.chomp("\n")
      else
        author = ""
      end

      text = text.sub(chapter.to_s, "|>|\\chapterspecial{#{title}}{#{subtitle}}{#{author}}\n |<|")
    end
    text
  end

  def prepare_verse(text)
    while text.match /<div class="verse">(.*?)<\/div>/m
      verse = text.match /<div class="verse">(.*?)<\/div>/m

      v = verse.to_s.gsub("<br />","<br />VeRsO")

      verse_text = PandocRuby.convert(v, {:from => :html, :to => :latex}, :chapters)

      verse_text = verse_text.chomp("\n")
      verse_text = verse_text.sub("\\&", "$$$&")
      verse_text = verse_text.gsub("VeRsO ","#\\\n")
      verse_text = verse_text.gsub("VeRsO\n","#\\\n")
      verse_text = verse_text.gsub("VeRsO","#\\\n")

      verse_text = verse_text.gsub("\n\n", "\\#\\!\\&")
      verse_text = verse_text.gsub("\\\\\n\\\\", "\\#\\!\n")

      text = text.sub(verse.to_s, "|>|\n\\begin{verse}\n#{verse_text}\\#\\!\n\\end{verse} |<|")
    end
    text
  end

  def prepare_alignment(text)
    while text.match /<p align="RIGHT">(.*?)<\/p>/m
      paragraph = text.match /<p align="RIGHT">(.*?)<\/p>/m
      paragraph_text = PandocRuby.convert(paragraph, {:from => :html, :to => :latex}, :chapters)
      paragraph_text = paragraph_text.sub("\\&", "$$$&")
      text = text.sub(paragraph.to_s, "|>|\\begin{flushright}#{paragraph_text}\\end{flushright}\n\r|<|")
    end

    while text.match /<p style="text-align: right;">(.*?)<\/p>/m
      paragraph = text.match /<p style="text-align: right;">(.*?)<\/p>/m
      paragraph_text = PandocRuby.convert(paragraph, {:from => :html, :to => :latex}, :chapters)
      paragraph_text = paragraph_text.sub("\\&", "$$$&")
      text = text.sub(paragraph.to_s, "|>|\\begin{flushright}#{paragraph_text}\\end{flushright}\n\r|<|")
    end

    while text.match /<p align="CENTER">(.*?)<\/p>/m
      paragraph = text.match /<p align="CENTER">(.*?)<\/p>/m
      paragraph_text = PandocRuby.convert(paragraph, {:from => :html, :to => :latex}, :chapters)
      paragraph_text = paragraph_text.sub("\\&", "$$$&")
      text = text.sub(paragraph.to_s, "|>|\\begin{center}#{paragraph_text}\\end{center}\n\r|<|")
    end

    while text.match /<p style="text-align: center;">(.*?)<\/p>/m
      paragraph = text.match /<p style="text-align: center;">(.*?)<\/p>/m
      paragraph_text = PandocRuby.convert(paragraph, {:from => :html, :to => :latex}, :chapters)
      paragraph_text = paragraph_text.sub("\\&", "$$$&")
      text = text.sub(paragraph.to_s, "|>|\\begin{center}#{paragraph_text}\\end{center}\n\r|<|")
    end
    text
  end

  def prepare_marker(text)
    while text.match /<span class=\"latex-inputbox\"(.*?)<\/span>/m
      marker_tag = text.match /<span class=\"latex-inputbox\"(.*?)<\/span>/m

      markertext = marker_tag.to_s.split("<a class=\"latex-close\"").first
      markertext = markertext.split(/<span class=\"latex-inputbox\"(.*?)>/).last

      text = text.sub(marker_tag.to_s, "|>|#{markertext} |<|")
    end

    while text.match /<span>[[:space:]]<\/span>/m
      text_tag = text.match /<span>[[:space:]]<\/span>/m
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