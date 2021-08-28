FactoryBot.define do
  factory :comment do
    association :article
    user { article.user }
    comment_content { Faker::Lorem.characters(number: 10) }
    rate { Faker::Lorem.characters(number: 3) }
  end
end
