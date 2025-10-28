require "rails_helper"

RSpec.describe "Logging In", type: :feature do
  describe "as default user" do
    let!(:user) { User.create!(name: "Jane", email: "jane@example.com", password: "password") }

    it 'Allows user to log in successfully' do

      visit root_path
      
      click_on "Kenny Loggins"
            
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Already have an account?")
      
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Log In"
      # save_and_open_page
      expect(page).to have_content("Welcome #{user.name}")
      # expect(session[:user_id]).to eq(user.id)
      expect(current_path).to eq(user_path(user))
    end
    
    it "It doesn't allow a log in with bad credentials" do
      
      visit root_path
      
      click_on "Kenny Loggins"
            
      expect(current_path).to eq(login_path)
      
      fill_in :email, with: user.email
      fill_in :password, with: "user.password"
      click_on "Log In"

      expect(page).to_not have_content("Welcome #{user.name}")
      expect(page).to have_content("Sorry, wrong credentials")
      expect(current_path).to eq(login_path)
    end
  end
end