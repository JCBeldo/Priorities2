FactoryBot.define do
  factory :submission do
    content { Faker::Travel::TrainStation.name(type: 'railway') }
    status { 0 }
    association :user
  end
end