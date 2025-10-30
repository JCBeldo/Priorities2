require 'rails_helper'

RSpec.describe "User submissions", type: :system do
  let(:user) { create(:user) }

  before(:each) do
    post "/login", params: { email: user.email, password: user.password }
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)
  end

  it "allows a user to submit multiple entries at once" do
    visit user_path(user)

    # Verify that there are multiple textareas rendered
    expect(page).to have_selector("textarea[name='submissions[][content]']", count: 5)

    # Fill out a few of them
    all("textarea[name='submissions[][content]']")[0].fill_in(with: "First submission")
    all("textarea[name='submissions[][content]']")[1].fill_in(with: "Second submission")
    all("textarea[name='submissions[][content]']")[2].fill_in(with: "Third submission")

    click_button "Submit Entries"

    # Expect redirect back to the user's show page
    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content("Priorities saved!")

    # Expect the user's submissions to exist in DB
    expect(user.submissions.count).to eq(3)

    # The form should now only show the remaining textareas
    expect(page).to have_selector("textarea[name='submissions[][content]']", count: 2)
  end

  it "does not create blank submissions" do
    visit user_path(user)
    click_button "Submit Entries"

    expect(user.submissions.count).to eq(0)
  end
end
