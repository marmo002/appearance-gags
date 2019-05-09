class WelcomeFormController < ApplicationController
  rescue_from ActionController::ParameterMissing do |exception|
    json_response({ message: error }, :unprocessable_entity)
  end

  before_action :done_with_profile?

  def internet_profile
    # session[:welcome_process] = session[:welcome_process] || "profile_creation"
  end

  def profile_image
    # session[:welcome_process] = session[:welcome_process] || "profile_creation"
  end

  def profile_social

  end

  def legal_info

  end

  def company_info

  end

  def release

  end

  def done_profile
    # render inline: "<%= params %>"
    if params['user']['signed_release'] == "1"
      current_user.signed_release = true
      current_user.profile_done = true
      current_user.save
      AppMailer.send_release_copy(current_user.id).deliver_later

      flash[:primary] = "Welcome to Get A Grip Studios"
      redirect_to dashboard_url
    else
      flash[:danger] = "Please accept release to continue"
      render :release

    end
  end

  def user_update
    respond_to do |format|
      current_user.attributes = user_params
      if current_user.save
        format.json {
          render json: {
            status: "success",
            type: "primary",
            message: "Profile updated successfully",
            avatar: current_user.avatar.attached? ? url_for(current_user.avatar) : nil,
            companylogo: current_user.companylogo.attached? ? url_for(current_user.companylogo) : nil,
            action: "welcome-form"
          }
        }
        format.html {
          flash[:primary] = "Profile updated successfully"
          redirect_back(fallback_location: welcome_path)
        }
      else
        format.json { render json: current_user.errors }
        format.html {
          flash[:danger] = "Fill required fields before continuing"
          session[:user_errors] = current_user.errors.as_json(full_messages: true)
          redirect_back(fallback_location: welcome_path)
        }
      end
    end#respond_to end
  end

private
  def done_with_profile?
    if current_user.profile_done
      redirect_to dashboard_url
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :dob,
      :email,
      :phone,
      :avatar,
      :password,
      :password_confirmation,
      :name_for_show,
      :title_for_show,
      :signed_release,
      :bio,
      :company_name,
      :companylogo,
      social_media: [ :profile, :facebook, :linkedin, :twitter, :instagram, :youtube, :other ],
      company_social_media: [ :website, :facebook, :linkedin, :twitter, :instagram, :youtube ]
    )
  end

end
