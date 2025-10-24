class SessionsController < ApplicationController
  def create
    # user = User.find_or_create_by(email: :email)
    
    # session[:user_id] = user.id

    # redirect_to root_path
  end

  def destroy
    reset_session
    # session[:user_id] = nil
    redirect_to root_path
  end
end