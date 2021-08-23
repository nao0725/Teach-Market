FactoryBot.define do
  factory :article do
     association :user
     title { Faker::Lorem.characters(number:10) }
     sub_title { Faker::Lorem.characters(number:5) }
     body { Faker::Lorem.characters(number:20) }
  end
end