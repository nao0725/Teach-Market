class Public::CommentsController < ApplicationController
  
  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comment.new(comment_params)
    @comment.article = @article
    if comment.save
      render :show
    else
      render :show
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id]) 
    if @comment.destroy
      render :show
    else
      render :show
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
  
end
