module Admin::PermissionHelper

  def active_or_not(value)
    tag = value ? "<span class='label label-success'>Sim</span>" : "<span class='label label-danger'>Não</span>"
    tag.html_safe
  end
end