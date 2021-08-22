class Article < ApplicationRecord

 belongs_to :user
 has_many :article_tags
 has_many :tags, through: :article_tags, dependent: :destroy
 has_many :notifications, dependent: :destroy
 has_many :comments, dependent: :destroy
 has_many :bookmarks, dependent: :destroy
 counter_culture :bookmark, column_name: "bookmark_count"


 #既にブックマークしていないか確認
 def bookmarked_by?(user)
   bookmarks.where(user_id: user).exists?
 end

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

 #星評価の平均値を表示
 def avg_score
   unless self.comments.empty?
     comments.average(:rate).round(1)
   else
     0.0
   end
 end

 #複数検索できるように設定
 def self.search(search_word)
  Article.joins(:tags).where(["title LIKE(?) OR body LIKE(?) OR sub_title LIKE(?) OR tag_name LIKE(?)",
                 "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%"]).distinct
 end

validates :title, presence: true, length: { minimum: 1 }
validates :body, presence: true

end
