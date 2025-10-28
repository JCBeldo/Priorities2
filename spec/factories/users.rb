FactoryBot.define do
  factory :user do
    name {Faker::Name.first_name}
    email {Faker::Internet.unique.email}
    password { 'test' }
    password_confirmation { 'test' }
    google_id {''}
    role { rand(0..2) }
  end
end