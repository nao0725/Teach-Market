class Public::HomesController < ApplicationController

  def top
  end

  def help
  end

  def home
    @articles = Article.all.page(params[:page]).per(10)
    @bookmarks = Article.find(Bookmark.group(:article_id)
                        .order(Arel.sql("count(article_id) desc"))
                        .pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id)
                      .order(Arel.sql("avg(rate) desc"))
                      .pluck(:article_id))
    @user = User.find(current_user.id)
    @follow_users = @user.all_following
    @follow_articles = Article.where(user_id:@follow_users)
                              .order(created_at "DESK")
                              .page(params[:page]).per(10)
  end

  def search
    @article = Article.new
    @articles = Article.search(params[:keyword])
                       .page(params[:page]).per(10)
    @bookmarks = Article.find(Bookmark.group(:article_id)
                        .order(Arel.sql("count(article_id) desc"))
                        .pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id)
                      .order(Arel.sql("avg(rate) desc"))
                      .pluck(:article_id))
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

end
