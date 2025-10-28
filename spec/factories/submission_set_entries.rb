FactoryBot.define do
  factory :submission_set_entry do
    submission_set
    submission
    position { 1 }
  end
end