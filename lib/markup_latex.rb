class MarkupLatex

  require 'nokogiri'
  require 'nokogiri-styles'

  module Skips
    SMALL = "smallskip"
    MEDIUM = "medskip"
    BIG = "bigskip"
  end

  IMAGE_TAGS = { 
    'small-intention' => 'imagempequena',
    'medium-intention' => 'imagemmedia',
    'big-intention' => 'imagemgrande'
  }

  def initialize(text)
    @text  = text    
  end
  
  def to_latex
    build_array(decode(@text.dup))
  end

  private

  def decode(content_text)
    coder ||= HTMLEntities.new
    coder.decode(content_text)
  end

  def build_array(content_text)
    content_text = convert_to_html content_text
    content_text = prepare_marker content_text
    content_text = prepare_image content_text, 'small-intention'
    content_text = prepare_image content_text, 'medium-intention'
    content_text = prepare_image content_text, 'big-intention'
    content_text = prepare_footnote content_text
    content_text = prepare_verse content_text
    content_text = prepare_skip content_text, Skips::SMALL
    content_text = prepare_skip content_text, Skips::MEDIUM
    content_text = prepare_skip content_text, Skips::BIG
    content_text = prepare_epigraph content_text
    content_text = prepare_chapter content_text
    content_text = prepare_alignment content_text
    compile_latex(prepare_text(content_text))
  end

  def convert_to_html text
    text = text.gsub("|>|","start_latex")
    text = text.gsub("|<|","end_latex")
    text = Nokogiri::HTML(text).to_s
    text = text.gsub("start_latex","<font>|>|")
    text = text.gsub("end_latex","|<|</font>")
    text
  end

  def convert_with_pandoc text
    PandocRuby.convert(text, {:from => :html, :to => :latex}, :chapters).chomp("\n").gsub("\\\\&", "$$$&")
  end

  def prepare_chapter(text)
    Nokogiri::HTML(text).css("section.chapter").each do |chapter|
      title = convert_with_pandoc chapter.css("h1").text
      subtitle = convert_with_pandoc chapter.css("h3").text
      author = convert_with_pandoc chapter.css("p").text
      text = text.sub(chapter.to_s, "<font>|>|\\chapterspecial{#{title}}{#{subtitle}}{#{author}}\n |<|</font>")
    end
    text
  end

  def prepare_epigraph(text)
    Nokogiri::HTML(text).css("section.epigraph").each do |epigraph|
      epigraph_origin = epigraph.to_s
      epigraph_author = convert_with_pandoc epigraph.css("span.epigraph-author").remove.text
      epigraph_text = convert_with_pandoc epigraph
      text = text.sub(epigraph_origin, "<font>|>|\\epigraph{#{epigraph_text}}{#{epigraph_author}} |<|</font>")
    end
    text
  end

  def prepare_alignment(text)
    Nokogiri::HTML(text).css("p[style], p[align]").each do |paragraph|
      paragraph_text = convert_with_pandoc paragraph
      if paragraph.styles['text-align'] == 'right' or paragraph['align'] == 'RIGHT'
        text = text.sub(paragraph.to_s, "<font>|>|\\begin{flushright}#{paragraph_text}\\end{flushright}\n\r|<|</font>")
      elsif paragraph.styles['text-align'] == 'center' or paragraph['align'] == 'CENTER'
        text = text.sub(paragraph.to_s, "<font>|>|\\begin{center}#{paragraph_text}\\end{center}\n\r|<|</font>")
      end
    end
    text
  end

  def prepare_footnote(text)
    Nokogiri::HTML(text).css("a[name]").each do |footnote|
      footnote_id = footnote['name']
      Nokogiri::HTML(text).css("a[href='##{footnote_id}']").each do |footnote_ref|
        footnote_container = footnote_ref.parent
        text = text.sub(footnote_container.parent.to_s, "")
        footnote_ref.remove
        footnote_text = convert_with_pandoc footnote_container.to_s
        text = text.sub(footnote.to_s, "<font>|>|\\footnote{#{footnote_text}} |<|</font>")        
      end
    end
    text
  end

  def prepare_marker(text)
    Nokogiri::HTML(text).css("span.latex-inputbox").each do |marker|
      marker_container = marker.to_s
      marker.children.css('a').remove
      marker_text = marker.text
      text = text.sub(marker_container, "<font>|>|#{marker_text} |<|</font>")
    end
    text
  end

  def prepare_verse(text)
    Nokogiri::HTML(text).css("div.verse").each do |verse|
      verse_text = convert_with_pandoc verse
      verse_text = verse_text.gsub("\\\\","\\#\\\n")
      verse_text = verse_text.gsub("\n\n","\\#\\!\n\n")
      text = text.gsub("<br />", "<br>")
      text = text.sub(verse.to_s, "<font>|>|\n\\begin{verse}\n#{verse_text}\\#\\!\n\\end{verse} |<|</font>")
    end
    text
  end

  def prepare_skip(text, skip_type)
    Nokogiri::HTML(text).css("div.#{skip_type}").each do |verse|
      text = text.sub(verse.to_s, "<font>|>|\\#{skip_type}{} |<|</font>")
    end
    text
  end

  def prepare_image(text, image_class)
    Nokogiri::HTML(text).css("img.#{image_class}").each do |image|
      image_type = IMAGE_TAGS[image_class]
      image_src = "#{Rails.public_path}#{image['src']}"
      image_alt = image['alt']
      text = text.sub(image.to_s, "<font>|>|\\#{image_type}{#{image_alt}}{#{image_src}} |<|</font>" )
    end
    text
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

end