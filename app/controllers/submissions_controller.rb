class SubmissionsController < ApplicationController
  def index
    # user = current_user
    # redirect_to user_path(user)
  end

  def create
    params[:submissions].each do |entry|
      next if entry[:content].blank?
      current_user.submissions.create(content: entry[:content])
    end
    redirect_to user_path(current_user), notice: "Priorities saved!"
  end
end