require 'rails_helper'

RSpec.describe "Session management", type: :request do
  describe "POST /login" do
    let!(:user) { User.create!(name: "Jane", email: "jane@example.com", password: "password") }

    context "with valid credentials" do
      it "logs the user in and redirects to the root path" do
        post "/login", params: { email: "jane@example.com", password: "password" }

        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(user_path(user))
        expect(flash[:success]).to eq("Welcome Jane")
      end
    end

    context "with invalid credentials" do
      it "does not log the user in and redirects to login path" do
        post "/login", params: { email: "jane@example.com", password: "wrongpassword" }
        
        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq("Sorry, wrong credentials")
      end
    end
  end
end
