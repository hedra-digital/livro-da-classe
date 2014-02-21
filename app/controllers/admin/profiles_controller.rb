class Admin::ProfilesController < Admin::ApplicationController

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      redirect_to admin_profiles_path, :notice => "Uma novo perfil foi definido."
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update_attributes(params[:profile])
    if @profile.save
      redirect_to admin_profiles_path, :notice => "Perfil atualizado."
    else
      render :edit
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to admin_profiles_path, :notice => "Perfil removido com sucesso."
  end

end