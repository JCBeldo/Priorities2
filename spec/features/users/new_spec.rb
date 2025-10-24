require 'rails_helper'

RSpec.describe "new user page", type: :feature do 
  describe "create a new user form" do
    it "verifies the functionality of the form" do
      visit new_user_path

      fill_in(:name, with: 'Silly')
      fill_in(:email, with: 'Silly@gmail.com')
      fill_in(:password, with: 'test')
      fill_in(:password_confirmation, with: 'test')

      click_button('Register')

      user = User.all.last

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('test')
      expect(current_path).to eq(user_path(User.all.last))
      expect(page).to have_content("Welcome to Priorities #{user.name}")
    end

    it "verifies the functionality of password confirmation" do
      visit new_user_path

      fill_in(:name, with: 'Silly')
      fill_in(:email, with: 'Silly@gmail.com')
      fill_in(:password, with: 'test')
      fill_in(:password_confirmation, with: 'not a test')

      click_button('Register')

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Bruh, you done fuq'd up. Try again.")
    end
    
    it "verifies the sad path of the form" do
      visit new_user_path

      fill_in(:name, with: '')
      fill_in(:email, with: 'Silly@gmail.com')
      fill_in(:password, with: 'test')
      fill_in(:password_confirmation, with: 'test')
      click_button('Register')

      expect(page).to have_content("Bruh, you done fuq'd up. Try again.")
    end
  end
end