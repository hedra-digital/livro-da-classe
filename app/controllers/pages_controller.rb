class PagesController < ApplicationController
  before_filter :public_view_check, except: :manual
  layout        :choose_layout

  def home
    render 'pages/home_scielo'
  end

  def contact
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]

    AdminMailer.contact_notifier(@name, @email, @content).deliver

    redirect_to root_path, notice: 'Sua mensagem foi enviada.'
  end

  def manual
    @manual_content = ''
    manual_content_file_name = 'public/manual_content.html'
    if File.exist? manual_content_file_name
      File.open(manual_content_file_name, 'r') do |file|
        while (line = file.gets)
          @manual_content << line
        end
      end
    end
    render 'pages/manual'
  end

  private

  def public_view_check
    redirect_to app_home_path if current_user
  end
end
