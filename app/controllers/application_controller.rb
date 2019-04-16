class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :company
  helper_method :require_login
  helper_method :is_admin?
  helper_method :authorized?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def company
    @company ||= Company.find(1)
  end

  def logged_in?
    session[:user_id] != nil
  end

  def is_admin?
    logged_in? && current_user.role == "admin"
  end

  def require_login
    unless logged_in?
      flash[:warning] = "You must log in first."
      redirect_to new_user_url
    end
  end

  def authorized?
    unless is_admin?
      flash[:warning] = "You are not allowed to visit this page."
      redirect_back(fallback_location: root_path)
    end
  end

end
