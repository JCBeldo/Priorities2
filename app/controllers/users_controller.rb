class UsersController < ApplicationController

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      flash[:success] = "Welcome #{user.name}"
      session[:user_id] = user.id

      redirect_to root_path
    else
      flash[:alert] = "Sorry, wrong credentials"

      redirect_to login_path
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome to Priorities #{user.name}"
      redirect_to user_path(user)
    else
      flash[:alert] = "Bruh, you done fuq'd up. Try again."
      redirect_to new_user_path
    end
  end

  def show
    user = User.find_by(name: params[:name])
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end