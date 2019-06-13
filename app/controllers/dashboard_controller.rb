class DashboardController < ApplicationController
  before_action :require_login
  before_action :authorized?, only: [ :admin_dashboard, :company_update ]

  def index
    if is_admin?
      redirect_to admin_url
      return
    end
    @page = params[:tab]
    @upcomming_bookings = current_user.bookings.upcomming.first(10)
    @past_bookings = current_user.bookings.past.first(10)
    @past_with_media = @past_bookings.select { |past| past.media_files.count > 0}
  end

  def admin_dashboard
    @users = User.where.not(id: current_user.id).first(33)
    @upcomming_bookings = Booking.upcomming.first(10)
    @past_bookings = Booking.past.first(10)
  end

  def release_update
    respond_to do |format|
      if company.update( params.require(:company).permit(:release) )
        format.json {
          render json: {
            status: "success",
            type: "primary",
            message: "Info updated successfully",
          }
        }
        format.html {
          flash[:primary] = "New info was saved"
          redirect_to dashboard_url
        }

        #updates all users to signed_release = false
        User.release_updated

      else
        format.json {
          render json: company.errors
         }
        format.html {
          flash[:danger] = "Please review form"
          session[:user_errors] = company.errors.as_json(full_messages: true)
          redirect_to dashboard_url
        }
      end
    end
  end

  def send_release
    AppMailer.send_release_copy(current_user.id).deliver_later
    flash[:primary] = "Email is on its way..."
    redirect_to dashboard_url
  end

  def user_update
    respond_to do |format|
      if current_user.update(user_params)
        format.json {
          render json: {
            status: "success",
            type: "primary",
            model: "user",
            message: "Profile updated successfully",
            avatar: current_user.avatar.attached? ? url_for(current_user.avatar) : nil,
            companylogo: current_user.companylogo.attached? ? url_for(current_user.companylogo) : nil
          }
        }
        format.html {
          flash[:primary] = "Profile updated successfully"
          redirect_to dashboard_url
        }
        # format.js
      else
        format.json { render json: current_user.errors, status: :bad_request  }
        format.html {
          flash[:danger] = "Please review form"
          session[:user_errors] = current_user.errors.as_json(full_messages: true)
          redirect_back(fallback_location: dashboard_path)
        }
      end
    end#respond_to end
  end

  def company_update
    respond_to do |format|
      if company.update(company_params)
        format.json {
          render json: {
            status: "success",
            type: "primary",
            modal: "company",
            message: "Info updated successfully",
          }
        }
        format.html {
          flash[:primary] = "New info was saved"
          redirect_to dashboard_url
        }
      else
        format.json {
          render json: company.errors, status: :bad_request
         }
        format.html {
          flash[:danger] = "Please review form"
          session[:user_errors] = company.errors.as_json(full_messages: true)
          redirect_to dashboard_url
        }
      end
    end# respond_to end

  end # company_update

private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :country,
      :state,
      :city,
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
      :company_country,
      :companylogo,
      social_media: [ :profile, :facebook, :linkedin, :twitter, :instagram, :youtube, :other ],
      company_social_media: [ :company_website, :company_facebook, :company_linkedin, :company_twitter, :company_instagram, :company_youtube ]
    )
  end

  def company_params
    params.require(:company).permit(
      :name,
      :address1,
      :address2,
      :city,
      :province,
      :postal_code,
      :email,
      :phone,
      :fax,
      :release
    )
  end

end
