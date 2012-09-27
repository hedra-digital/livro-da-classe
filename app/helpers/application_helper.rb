module ApplicationHelper

  def flash_message
  	messages = ""
    flash.each do |type, content|
      messages = content_tag(:div, button_tag('&#215;'.html_safe, :type => 'button', :class => 'close', :'data-dismiss' => 'alert', :name => nil) + content, :class => "alert alert-#{ type == :notice ? "success" : "error" }")
    end
    messages
  end

  def full_text(book)  
    builder = proc do |text|
      "\\chapter{#{text.title}}\n#{k_to_latex(text.content)}\n" unless text.content.to_s.size == 0
    end
    
    book.texts.map(&builder).join
  end

  def k_to_latex(text)
    HedraLatex.convert(Kramdown::Document.new(text).root[0]
  end

  def lesc(text)
    LatexToPdf.escape_latex(text)
  end

  def logged_in_as
    if session['admin_logged'].present?
      return "admin"
    elsif session['professor_logged'].present?
      return "professor"
    elsif session['student_logged'].present?
      return "estudante"
    end
  end

  def user_color
    case logged_in_as
      when 'admin'
        return 'adm-color'
      when 'professor'
        return 'tea-color'
      else 'estudante'
        return 'stu-color'
    end
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

end