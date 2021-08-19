class Public::NotificationsController < ApplicationController
   
   def index
      @notifications = current_user.passive_notifications.page(params[:page]).per(10)
      @notifications.where(checked: false).each do |notification|
         notification.update_attributes(checked: true)
          @visitor = notification.visitor
          @visited = notification.visited
      end
   end
   
  #フォローされた際の通知を送る
  def create_follow_notification(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
        )
      notification.save if notification.valid?
    end
  end
  
  #ブックマークされていない場合のみ、通知レコード作成
  def create_bookmark_notification(current_user)
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
def create_comment_notification(current_user, comment_id)
 temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
 temp_ids.each do |temp_id|
  save_comment_notification(current_user, comment_id, temp_id["user_id"])
 end
 save_comment_notification(current_user, comment_id, user_id) if temp_ids.blank?
end

#１つの投稿に対して複数回通知を送る
def save_comment_notification(current_user, comment_id, visited_id)
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

end
