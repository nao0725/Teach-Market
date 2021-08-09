class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  
  validates :comment_content, presence: true
end
