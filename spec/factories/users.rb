FactoryBot.define do
  factory :user, aliases: [:follower,:followed] do
    name { Faker::Lorem.characters(number: 4) }
    nickname { Faker::Lorem.characters(number: 4) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
