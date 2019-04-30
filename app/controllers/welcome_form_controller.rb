class WelcomeFormController < ApplicationController
  before_action :done_with_profile?

  def profile_creation

  end

private
  def done_with_profile?
    if current_user.profile_done
      redirect_to dashboard_url
    end
  end

end
