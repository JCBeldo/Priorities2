class SubmissionSetsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if user.submission_sets.exists?
      redirect_to user.submission_sets.last, alert: "You already have a set of Priorities"
      return
    end

    @submission_set = SubmissionSet.create!(owner: user)

    random_subs = Submission.where.not(user_id: user.id).order("RANDOM()").limit(5)
# require 'pry'; binding.pry
    random_subs.each_with_index do |sub, i|
      SubmissionSetEntry.create!(
        submission_set: @submission_set,
        submission: sub,
        position: i + 1
      )
    end
    redirect_to submission_set_path(@submission_set)
  end

  def show
    @submission_set = SubmissionSet.includes(submission_set_entries: :submission).find(params[:id])
    @entries = @submission_set.submission_set_entries.order(:position)
    # require 'pry'; binding.pry
  end

  def update
    @submission_set = SubmissionSet.find(params[:id])

    params[:entries].each do |entry|
      SubmissionSetEntry.find(entry[:id]).update(position: entry[:position])
    end

    respond_to do |format|
      format.html { redirect_to @submission_set, notice: "Order updated." }
      format.json { head :ok }
    end
  end
end