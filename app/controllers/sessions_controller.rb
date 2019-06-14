class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      # redirect to first request if any
      # or go to dashboard otherwise
      redirect_to(session[:return_to] || dashboard_path)
      session[:return_to] = nil

      flash[:primary] = "You logged in sucessfully."
    else
      flash[:danger] = "Email or password are incorrect. Please try again."
      redirect_to new_user_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_user_url
    flash[:primary] = "You have successfully logged out."
  end
end
