class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :article
  
  #二度連続でブックマーク登録しないように設定
  validates :user_id, uniqueness: { scope: :article_id }
end
