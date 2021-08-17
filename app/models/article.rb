class Article < ApplicationRecord

 belongs_to :user
 has_many :article_tags
 has_many :tags, through: :article_tags, dependent: :destroy
 has_many :notifications, dependent: :destroy
 has_many :bookmarks, dependent: :destroy
 has_many :comments, dependent: :destroy

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
  Article.where(["title LIKE(?) OR body LIKE(?) OR sub_title LIKE(?) ",
                 "%#{search_word}%", "%#{search_word}%", "%#{search_word}%"])
 end

 #ブックマークされていない場合のみ、通知レコード作成
 def create_notification_bookmark!(current_user)
  temp = Notification.where(["visitor_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, "bookmark"])
  if temp.balnk?
   notification = current_user.active_notifications.new(
    article_id: id,
    visited_id: user_id,
    action: "bookmark"
    )
   if notification.visitor_id == notification.visited_id
    notification.checked = true
   end
   notification.save if notification.valid?
  end
 end

 #自分以外のコメントしている人を取得し、全員に通知を送る
def create_notification_comment!(current_user, comment_id)
 #selectのとこfindでも行ける？？？
 temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
 temp_ids.each do |temp_id|
  save_notification_comment!(current_user, comment_id, temp_id["user_id"])
 end
 save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
end

#１つの投稿に対して複数回通知を送る
def save_notification_comment!(current_user, comment_id, visited_id)
 notification = current_user.active_notifications.new(
  article_id: id,
  comment_id: comment_id,
  visited_id: visited_id,
  action: "comment"
  )

 #自分の投稿に対するコメントは通知済扱い
  if notification.visitor_id == notification.visited_id
    notification.checked = true
  end
  notification.save if notification.valid?
end

validates :title, presence: true, length: { minimum: 1 }
validates :body, presence: true

end
