class SubmissionSet < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :submission_set_entries, dependent: :destroy
  has_many :submissions, through: :submission_set_entries
  # has_many :submission_set_guesses

end