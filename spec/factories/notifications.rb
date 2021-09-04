FactoryBot.define do
  factory :notification do
    association :article
    association :comment
  end
end
