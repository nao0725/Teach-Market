class Public::RelationshipsController < ApplicationController

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    notification = Notification.new()==
    notification.create_follow_notification(current_user, @user.id)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end
