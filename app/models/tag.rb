class Tag < ApplicationRecord
  has_many :articles, through: :article_tags, dependent: :destroy
  has_many :article_tags, dependent: :destroy

  validates :tag_name, presence: true
end
