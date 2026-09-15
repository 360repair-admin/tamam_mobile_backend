class Admin::SessionsController < ApplicationController
  layout "admin"

  before_action :redirect_if_authenticated, only: [ :new, :create ]

  helper_method :current_admin

  def new
  end

  def create
    admin_user = Admin.find_by(email: params[:email].to_s.strip.downcase)

    if admin_user&.active? && admin_user.authenticate(params[:password])
      reset_session
      session[:admin_id] = admin_user.id

      redirect_to admin_root_path
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session

    redirect_to admin_login_path, notice: "You have been logged out."
  end

  private

  def redirect_if_authenticated
    redirect_to admin_root_path if current_admin&.active?
  end

  def current_admin
    return @current_admin if defined?(@current_admin)

    @current_admin = Admin.find_by(id: session[:admin_id])
  end
end
