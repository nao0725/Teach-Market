FactoryBot.define do
  factory :tag do
    #association :article
    tag_name { Faker::Lorem.characters(number: 2) }
  end
end
