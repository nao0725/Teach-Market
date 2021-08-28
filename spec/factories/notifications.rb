FactoryBot.define do
  factory :notification do
    association :bookmark
    association :comment
    association :visitor
    association :visited
  end
end
