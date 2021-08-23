class Public::HomesController < ApplicationController

  def top
  end

  def help
  end

  def home
    @user = current_user
    @articles = Article.all.page(params[:page]).per(10).order(created_at: "desc")
    @bookmarks = Article.find(Bookmark.group(:article_id)
                        .order(Arel.sql("count(article_id) desc"))
                        .pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id)
                      .order(Arel.sql("avg(rate) desc"))
                      .pluck(:article_id))
    @follow_articles = Article.where(user_id: [current_user.following_ids])
                              .order(created_at: "desc")
                              .page(params[:page]).per(10)
  end

  def search
    @article = Article.new
    @articles = Article.search(params[:keyword])
                       .page(params[:page]).per(10)
    @bookmarks = Article.joins(:bookmarks)
                        .search(params[:keyword])
                        .where(Bookmark.group(:articles)
                          .order(Arel.sql("bookmark_count desc"))
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
