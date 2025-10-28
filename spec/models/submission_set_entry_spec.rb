require 'rails_helper'

RSpec.describe SubmissionSetEntry, type: :model do
  describe "associations" do
    it { should belong_to(:submission_set) }
    it { should belong_to(:submission) }
  end

  describe "validations" do
    it { should validate_presence_of(:submission_set) }
    it { should validate_presence_of(:submission) }
  end

  describe "ordering" do
  let(:submission_set) { create(:submission_set) }
  let!(:entry1) { create(:submission_set_entry, submission_set: submission_set, position: 1) }
  let!(:entry2) { create(:submission_set_entry, submission_set: submission_set, position: 2) }

    it "maintains order by position" do
    expect(submission_set.submission_set_entries.order(:position).first).to eq(entry1)
    end
  end
end
