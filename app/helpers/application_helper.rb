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

  def user_id(user)
    tags = ""
    if user.email.present? && user.name.present?
      tags << gravatar_image_tag(user.email, :alt => user.name, :class => 'user-gravatar', :gravatar => { :default => "#{root_url}assets/avatar.png" })
      tags << user.email
    elsif user.email.present?
      tags << gravatar_image_tag(user.email, :class => 'user-gravatar', :gravatar => { :default => "#{root_url}assets/avatar.png" })
      tags << user.email
    end
    tags.html_safe
  end

  def is_project?(book=nil)
    book ||= @book

    if book.nil?
      return false
    else
      book.project.present? and book.project.engaged?
    end
  end

  def publisher_logo
    Publisher.get_current(request.host).logo.url(:normal)
  end

  def publisher_official_name
    Publisher.get_current(request.host).official_name
  end

  def publisher_name
    Publisher.get_current(request.host).name
  end

  def publisher_address_info
    p = Publisher.get_current(request.host)
    "#{p.address}<br>#{p.district}<br>#{p.city} - #{p.uf}<br>Tel. #{p.telephone}<br>".html_safe
  end
end
