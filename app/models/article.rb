class Article < ApplicationRecord

 has_many :article_tags
 has_many :tags, through: :article_tags, dependent: :destroy
 belongs_to :user


 #複数のタグ付け機能で実装
 def tags_save(tag_list)
   if self.tags != nil
    article_tags_records = ArticleTag.where(article_id:self.id)
    article_tags_records.destroy_all
   end

   tag_list.each do |tag|
    inspected_tag = Tag.where(tag_name:tag).first_or_create
    self.tags << inspected_tag
   end

  end

 validates :title, presence: true, length: { minimum: 20 }
 validates :body, presence: true
end
