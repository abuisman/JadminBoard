class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :set_sidebar
  
  layout 'admin'

  def set_sidebar
    @sidebar = 'admin/admins/sidebar'
  end

end
