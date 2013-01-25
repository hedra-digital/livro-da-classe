module ApplicationHelper

  def flash_message
    flash.inject("") { |sum, obj| sum << content_tag(:div, button_tag('&#215;'.html_safe, :type => 'button', :class => 'close', :'data-dismiss' => 'alert', :name => nil) + obj[1], :class => "alert alert-#{ obj[0] == :notice ? "success" : "error" }") }.html_safe
  end

end
