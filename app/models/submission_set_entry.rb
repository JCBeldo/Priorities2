class SubmissionSetEntry < ApplicationRecord
  belongs_to :submission_set
  belongs_to :submission

  # acts_as_list scope: :submission_set

  validates :submission, presence: true
  validates :submission_set, presence: true
end