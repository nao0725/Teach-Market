FactoryBot.define do
  factory :comment do
    association :article
    user {article.user }
  end
end