class Admin::PermissionsController < Admin::ApplicationController

  def index
    @permissions = Permission.order("profile_id, book_status_id").all
  end

  def edit
    @permissions = Permission.order("profile_id, book_status_id").all
  end

  def update
    @permission = Permission.find(params[:id])
    @permission.update_attributes(params[:permission])
    if @permission.save
      redirect_to edit_admin_permission_path, :notice => "Permissão atualizada."
    else
      render :edit
    end
  end

end