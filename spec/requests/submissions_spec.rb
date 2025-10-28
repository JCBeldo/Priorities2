require 'rails_helper'

RSpec.describe "Submissions", type: :request do
  let(:user) { create(:user) }

  before(:each) do
  allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
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

      xit "creates multiple submissions for the current user" do
        expect {
          post submissions_path, params: valid_params
        }.to change { user.submissions.count }.by(2)
      end

      xit "redirects back to the user's show page" do
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

      xit "does not create any submissions" do
        expect {
          post submissions_path, params: invalid_params
        }.not_to change { user.submissions.count }
      end
    end
  end
end
