class Article < ApplicationRecord

 belongs_to :user
 has_many :tags, through: :article_tags

 #複数のタグ付け機能で実装
 def tags_save(tag_list)
   if self.tags != nil
    article_tags_records = ArticleTag.where(article_id:self.id)
    article_tags_records.destroy.all
   end

   tag_list.each do |tag|
    inspected_tag = Tag.where(tag_name:tag).first_or_create
    self.tags << inspected_tag
   end

  end
end
