require 'rails_helper'

RSpec.describe "Users Show Page", type: :feature do
  let(:user) { create(:user) }
  let(:user1) { create(:user) }

  before(:each) do
  allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
  end
  describe "What a user sees on the show page" do
    it "should display directions for how a user should submit entries." do
      visit user_path(user)
      expect(page).to have_content("Please submit 5 priorities in the five empty boxes. Once all 5 have been submitted you can click a button to take you to your 5 new random priorities.")
    end
  end

  context "when the user has fewer than 5 submissions" do
    before(:each) do
      create_list(:submission, 2, user: user) # They have submitted 2 out of 5
      visit user_path(user)
    end

    it "shows a progress message" do
      expect(page).to have_content("You have submitted 2 out of 5 entries")
    end

    it "shows a form with 3 empty submission fields" do
      expect(page).to have_selector("textarea[name='submissions[][content]']", count: 3)
    end

    it "has a Submit button" do
      expect(page).to have_button("Submit Entries")
      # save_and_open_page
    end
  end

  context "when the user has already submitted 5 entries, but others haven't" do
    before(:each) do
      create_list(:submission, 5, user: user)
      visit user_path(user)
    end

    it "shows a pending message" do
      expect(page).to have_content("Waiting for other players to finish their submissions...")
    end

    it "does not show the submission form" do
      # save_and_open_page
      expect(page).not_to have_selector("form#new_submissions_form")
    end

    it "should show a button to visit submissions show page" do
      expect(page).to_not have_button("Go see your new priorties!")
    end
  end

  context "when the user has already submitted 5 entries, as well as others" do
    before(:each) do
      create_list(:submission, 5, user: user)
      create_list(:submission, 5, user: user1)
      visit user_path(user)
    end

    it "shows a completion message" do
      expect(page).to have_content("All players have completed their 5 submissions.")
    end

    it "does not show the submission form" do
      # save_and_open_page
      expect(page).not_to have_selector("form#new_submissions_form")
    end

    it "should show a button to visit submissions show page" do
      expect(page).to have_button("Go see your new priorties!")
    end

    it "creates a new submission set on click" do
      expect {
        click_button "Go see your new priorties!"
      }.to change(SubmissionSet, :count).by(1)
    end
  end
end
