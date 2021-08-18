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
end
