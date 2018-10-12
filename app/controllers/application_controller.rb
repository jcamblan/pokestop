class ApplicationController < ActionController::Base

  breadcrumb 'Accueil', :root_path

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, :alert => exception.message }
    end
  end

  def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
  end

end
