require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe "relationships" do
    it { should belong_to :user }
  end
end