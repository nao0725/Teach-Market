class Public::CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    @review = @comment.rate
    @review.save
    if @comment.save
     redirect_to request.referer
    else
     redirect_to request.referer
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
     redirect_to request.referer
    else
     redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :article_id, :user_id, :rate)
  end

end
