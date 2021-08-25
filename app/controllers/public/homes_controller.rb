class Public::HomesController < ApplicationController

  def top
  end

  def help
  end

  def home
    @user = current_user
    @today_user_post_ranks = User.where(id: Article.group(:user_id)
                                 .created_today
                                 .order('count(user_id) desc')
                                 .limit(3).pluck(:user_id))
                                 
    @articles = Article.all.page(params[:page]).per(10)
                           .order(created_at: "desc")
                           
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
    @user = current_user
    @today_user_post_ranks = User.where(id: Article.group(:user_id)
                                 .where(created_at: Time.current.all_day)
                                 .order('count(user_id) desc')
                                 .limit(3).pluck(:user_id))
    @article = Article.new
    @articles = Article.search(params[:keyword])
                       .page(params[:page]).per(10)
    @bookmarks = Article.joins(:bookmarks) # Article.order(:bookmarks_count)で解決されるのでjoinsがいらない
                        .search(params[:keyword])
                        .where(Bookmark.group(:article_id)
                          .order(Arel.sql("bookmark_count desc"))
                          .pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id)
                      .order(Arel.sql("avg(rate) desc"))
                      .pluck(:article_id)) # Article.joins(:comments).search("フラッシュ").order(Arel.sql("AVG(comments.rate) DESC")).group(Arel.sql("comments.article_id")
    @follow_articles = Article.where(user_id: [current_user.following_ids])
                              .order(created_at: "desc")
                              .page(params[:page]).per(10)
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
