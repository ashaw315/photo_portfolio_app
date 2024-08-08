FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    password { 'password' }
    password_confirmation { 'password' }
    bio { Faker::Lorem.sentence } # Add a fake bio
    profile_picture { Faker::Avatar.image } # Add a fake profile picture URL
  end
end
  