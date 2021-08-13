class Tag < ApplicationRecord

has_many :tags, through: :article_tags
has_many :article_tags

# tag検索できるように設定
 def self.search(search_word)
  Tag.where(["tag_name LIKE(?)","%#{search_word}%"])
 end

end
