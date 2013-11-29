module Admin::ApplicationHelper

  def publisher_admin_logo
    Publisher.get_current(request.host).logo_alternative.url(:normal)
  end

end
