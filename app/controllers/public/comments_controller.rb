class Public::CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    @comment = current_user.comments.new(comment_params)
    @comment_new = Comment.new
    @comment.article_id = @article.id
    if @comment.save
      @comment = Comment.new
      notification = Notification.new()
      notification.create_comment_notification(current_user, @comment, @article.user.id, @article.id)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    if Comment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    else
    redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :article_id, :user_id, :rate)
  end

end
