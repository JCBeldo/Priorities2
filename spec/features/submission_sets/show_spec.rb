require 'rails_helper'

RSpec.describe "SubmissionSet rearrangement", type: :feature do
  let!(:user) { create(:user) }
  let!(:submissions) { create_list(:submission, 10) }
  let!(:submission_set) { create(:submission_set, owner: user) }

  before do
    submissions.sample(5).each_with_index do |submission, index|
      create(:submission_set_entry, submission_set: submission_set, submission: submission, position: index + 1)
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it "displays the random submissions" do
    visit submission_set_path(submission_set)

    expect(page).to have_content("Arrange the priorities as you see fit.")
    # expect(page).to have_selector(".submission-entry", count: 5)
  end

  it "allows the user to submit a new order" do
    visit submission_set_path(submission_set)

    # simulate reordering: fill order fields
    all("input[name*='entries']").each_with_index do |input, i|
      input.set(i + 2) # arbitrary new order
    end

    click_button "Save Order"
    # expect(page).to have_content("Order saved!")
  end
end
