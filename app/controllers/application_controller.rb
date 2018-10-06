class ApplicationController < ActionController::Base

  breadcrumb 'Accueil', :root_path

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to admin_path, :alert => exception.message }
    end
  end
end
