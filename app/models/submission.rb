class Submission < ApplicationRecord
  belongs_to :user
  has_many :submission_set_entries

  enum :status, { approved: 0, rejected: 1 }
end