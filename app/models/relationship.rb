class Relationship < ApplicationRecord
  #followerがフォローした人、followedがフォローされた人
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
