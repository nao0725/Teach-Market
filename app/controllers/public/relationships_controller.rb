class Public::RelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    notification = Notification.new
    notification.create_follow_notification(current_user, @user.id)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
  end
end
