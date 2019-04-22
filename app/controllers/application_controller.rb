class ApplicationController < ActionController::Base

  helper_method :current_user
  helper_method :company
  helper_method :require_login
  helper_method :is_admin?
  helper_method :authorized?
  helper_method :get_hash_data
  helper_method :booking_text

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

  def get_hash_data(data)
    if data.class == Hash && !data.values[0].empty?
      data.reject { |k, v| v.empty? }
    else
      false
    end
  end

  def booking_text
    {
      headphone: "I have over ear headphone with on-board over mouth microphone connected to your computer via USB port.",
      webcam: "I have a webcam with the appropriate lighting and in a good recording environment (i.e no uncontrolled noises and where interruptions can be eliminated).",
      confirmation: "I confirm that the above information is current and accurate."
    }
  end

end
