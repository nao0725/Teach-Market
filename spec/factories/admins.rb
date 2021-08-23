FactoryBot.define do
  factory :admin do
     name { Faker::Lorem.characters(number:4) }
     email { Faker::Internet.email }
     password { 'password' }
     password_confirmation { 'password' }
  end
end