require 'rails_helper'

RSpec.describe "Submissions", type: :request do
  let(:user) { create(:user) }
        # require 'pry'; binding.pry

  before(:each) do
  post "/login", params: { email: user.email, password: user.password }
  end

  describe "POST /submissions" do
    context "with valid content" do
      let(:valid_params) do
        {
          submissions: [
            { content: "First idea" },
            { content: "Second idea" }
          ]
        }
      end

      it "creates multiple submissions for the current user" do
        post submissions_path, params: valid_params
        expect(user.submissions.count).to eq(2)
      end
      it "redirects back to the user's show page" do
        post submissions_path, params: valid_params
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "with blank content" do
      let(:invalid_params) do
        {
          submissions: [
            { content: "" },
            { content: nil }
          ]
        }
      end

      it "does not create any submissions" do
        expect {
          post submissions_path, params: invalid_params
        }.not_to change { user.submissions.count }
      end
    end
  end
end
