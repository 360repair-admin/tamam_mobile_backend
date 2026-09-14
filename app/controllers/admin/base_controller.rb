class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :require_admin!

  helper_method :current_admin_user

  private

  def current_admin_user
    return @current_admin_user if defined?(@current_admin_user)

    @current_admin_user = Admin.find_by(id: session[:admin_user_id])
  end

  def require_admin!
    return if current_admin_user&.active?

    session[:admin_user_id] = nil

    redirect_to admin_login_path, alert: "Please log in to continue."
  end
end
