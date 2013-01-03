module ApplicationHelper

  def flash_message
    messages = ""
    flash.each do |type, content|
      messages = content_tag(:div, button_tag('&#215;'.html_safe, :type => 'button', :class => 'close', :'data-dismiss' => 'alert', :name => nil) + content, :class => "alert alert-#{ type == :notice ? "success" : "error" }")
    end
    messages
  end

end
