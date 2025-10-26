FactoryBot.define do
  factory :submission_set do
    association :owner, factory: :user
  end
end