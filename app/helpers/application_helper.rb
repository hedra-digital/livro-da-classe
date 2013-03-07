module ApplicationHelper
  include AuthorizationHelper

  def flash_message
    types = { :notice => 'success', :alert => 'error', :info => 'info' }
    flash.inject("") do |sum, message|
      content_tag :div, :class => "alert alert-#{types[message[0]]}" do
        button_tag('&#215;'.html_safe, :type => 'button', :class => 'close', :'data-dismiss' => 'alert', :name => nil) +
        message[1].html_safe
      end
    end
  end

  def lesc(text)
    LatexToPdf.escape_latex(text)
  end

  def is_project?(book=nil)
    book ||= @book

    if book.nil?
      return false
    else
      book.project.present?
    end
  end
end
