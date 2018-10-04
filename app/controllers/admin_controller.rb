class AdminController < ApplicationController
  before_action :authenticate_user!
  
  layout 'admin'

  breadcrumb 'Admin', :admin_path

  def index
  end

end
