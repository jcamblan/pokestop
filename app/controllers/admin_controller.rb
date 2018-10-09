class AdminController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  layout 'admin'

  breadcrumb 'Admin', :admin_path



  def index
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end
    
end
