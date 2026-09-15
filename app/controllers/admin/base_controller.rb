class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :require_admin!

  helper_method :current_admin

  private

  def current_admin
    return @current_admin if defined?(@current_admin)

    @current_admin = Admin.find_by(id: session[:admin_id])
  end

  def require_admin!
    return if current_admin&.active?

    session[:admin_id] = nil

    redirect_to admin_login_path, alert: "Please log in to continue."
  end
end
