class WelcomeFormController < ApplicationController
  rescue_from ActionController::ParameterMissing do |exception|
    json_response({ message: error }, :unprocessable_entity)
  end

  before_action :done_with_profile?

  def legal_info

  end

  def internet_profile
  end

  def profile_image
  end

  def profile_social

  end

  def company_image

  end

  def company_legal

  end

  def company_social

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

    if params['has_company']
      session[:has_company] = true
    else
      session[:has_company] = nil
    end

    respond_to do |format|
      if current_user.update(user_params)
        format.json {
          render json: {
            status: "success",
            type: "primary",
            message: "Profile updated successfully",
            avatar: current_user.avatar.attached? ? url_for(current_user.avatar) : nil,
            companylogo: current_user.companylogo.attached? ? url_for(current_user.companylogo) : nil,
            model: "welcome-form"
          }
        }
        format.html {
          flash[:primary] = "Profile updated successfully"
          redirect_back(fallback_location: welcome_path)
        }
      else
        format.json { render json: current_user.errors, status: :bad_request  }
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
      :company_legal_name,
      :company_phone,
      :company_address1,
      :company_address2,
      :company_city,
      :company_province,
      :company_postalcode,
      :companylogo,
      social_media: [ :profile, :facebook, :linkedin, :twitter, :instagram, :youtube, :other ],
      company_social_media: [ :company_website, :company_facebook, :company_linkedin, :company_twitter, :company_instagram, :company_youtube ]
    )
  end

end
