class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  before_filter :set_current_user_and_ip
  def set_current_user_and_ip
    User.current_user = current_user
    User.current_ip_address = request.remote_ip
  end

  protected

  def authenticate_admin
    redirect_to root_url unless current_user.admin
  end

  def authenticate
    unless current_user
      session[:return_to] = request.env['REQUEST_URI']
      flash[:notice] = "Please sign in first"
      redirect_to signin_path
    end
  end
end
