class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmarks = Bookmark.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def create
    @article = Article.find(params[:article_id])
    @bookmark = @article.bookmarks.new(user_id: current_user.id)
    if @bookmark.save
      notification = Notification.new
      notification.create_bookmark_notification(current_user, @article.user_id, @article.id)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @bookmark = @article.bookmarks.find_by(user_id: current_user.id)
    if @bookmark.present?
      @bookmark.destroy
    else
      redirect_to request.referer
    end
  end
end
