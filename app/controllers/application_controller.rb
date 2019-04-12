class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :require_login
  helper_method :social_media_present

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id] != nil
  end

  def require_login
    unless logged_in?
      flash[:warning] = "You must log in first."
      redirect_to new_user_url
    end
  end

  def social_media_present
    current_user.personal_info["social_media"]
  end

end
