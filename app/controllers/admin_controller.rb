class AdminController < ApplicationController
  layout 'admin'

  breadcrumb 'Admin', :admin_path

  def index
  end

end
