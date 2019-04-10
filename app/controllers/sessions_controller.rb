class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_url
      flash[:primary] = "Your logged in sucessfully."
    else
      flash[:danger] = "Email or password incorrect. Please try again."
      redirect_to our_users_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to our_users_url
    flash[:primary] = "Your logged out sucessfully."

  end
end
