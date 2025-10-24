require 'rails_helper'

RSpec.describe "landing page", type: :request do
  describe "Land of Link in" do

    it "responds successfully" do
      get root_path
      expect(response).to be_successful
    end

    it 'has a link to log in with Google' do
      visit root_path
      expect(page).to have_link("Login")
    end

    it 'has a link to log in with account' do
      visit root_path
      expect(page).to have_link("Kenny Loggins")
    end

    it 'has a link to sign up' do
      visit root_path
      expect(page).to have_link("Sign Up")
    end
  end
end