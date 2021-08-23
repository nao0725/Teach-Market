FactoryBot.define do
  factory :notification do
    association :bookmark
    association :comment
    association :visitor
    application :visited
  end
end