class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_sidebar
  
  # You may want to move this to the ApplicationController if you use breadcrumbs-on-rails in the rest of the site
  # In that case create some sort of check on the class of the controller.
  add_breadcrumb "Dashboard", :admin_dashboard_path
  
  layout 'admin'

  def set_sidebar
    @sidebar = 'admin/admins/sidebar'
  end

end
