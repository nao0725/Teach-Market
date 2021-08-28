FactoryBot.define do
  factory :relationship do
    association :followed
    association :follower
    association :user
  end
end
