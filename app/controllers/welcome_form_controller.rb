class WelcomeFormController < ApplicationController
  # before_action :is_new_user?

  def profile_creation
  end

private
  def is_new_user?
    redirect_to dashboard_path unless session[:user_profile_setup]
  end

end
