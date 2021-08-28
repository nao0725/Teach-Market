FactoryBot.define do
  factory :bookmark do
    association :article
    user { article.user }
  end
end
