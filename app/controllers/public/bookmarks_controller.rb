class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @article = Article.find(params[:article_id])
    @bookmark = @article.bookmarks.new(user_id: current_user.id)
    if boookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
    
    def destroy
      @article = Article.find(params[:article_id])
      @bookmark = @article.bookmarks.find_by(user_id: current_user.id)
      if bookmark.present?
        bookmark.destroy
        redirect_to request.referer
      else
        redirect_to request.referer
      end
  end
end