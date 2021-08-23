FactoryBot.define do
  factory :relationship do
    association :followed
    association :follower
    application :user
  end
end