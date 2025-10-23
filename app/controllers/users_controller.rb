class UsersController < ApplicationController

  def login_form

  end

  def login
    # require 'pry'; binding.pry
    user = User.find_by(email: params[:email])
    # user = current_user
    if user.authenticate(params[:password])
      # require 'pry'; binding.pry
    # if user.present?
      flash[:success] = "Welcome #{user.name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert] = "Sorry, wrong credentials"
      redirect_to login_path
    end
  end
end