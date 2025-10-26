require 'rails_helper'

RSpec.describe SubmissionSet, type: :model do
  let!(:owner) { create(:user) }
  let!(:submission_set) { create(:submission_set, owner: owner) }
  let!(:submissions) { create_list(:submission, 5) }

  describe "relationships" do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:submission_set_entries).dependent(:destroy) }
    it { should have_many(:submissions).through(:submission_set_entries) }
  end

  describe "assigning submissions" do
    it "can associate multiple submissions through entries" do
      submissions.each do |submission|
        submission_set.submission_set_entries.create(submission: submission)
        # require 'pry'; binding.pry
      end

      expect(submission_set.submissions.count).to eq(5)
      expect(submission_set.submissions).to include(*submissions)
    end
  end
end
