class Public::HomesController < ApplicationController
  def top
  end

  def help
  end

  def home
    @user = current_user
    @articles = Article.all.page(params[:page]).per(10).
                order(created_at: "desc")
    @bookmarks = Article.find(Bookmark.group(:article_id).
                        order(Arel.sql("count(article_id) desc")).
                        pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id).
                      order(Arel.sql("avg(rate) desc")).
                      pluck(:article_id))
    @follow_articles = Article.where(user_id: [current_user.following_ids]).
                              order(created_at: "desc").
                              page(params[:page]).per(10)
    @today_post_ranks_user = Article.group(:user_id).where(created_at: Time.current.all_day).order('count(user_id) desc').limit(10).pluck(:user_id)
    @today_ranks = []
    @today_post_ranks_user.each do |user_id|
      @today_ranks.push({
        "user" => User.find(user_id),
        "count" => Article.where(created_at: Time.current.all_day).where(user_id: user_id).count,
      })
    end
  end

  def search
    @user = current_user
    @today_user_post_ranks = User.where(id: Article.group(:user_id).
                                 where(created_at: Time.current.all_day).
                                 order('count(user_id) desc').limit(3).
                                 pluck(:user_id))
    @article = Article.new
    @articles = Article.search(params[:keyword]).
      page(params[:page]).per(10)
    @bookmarks = Article.order(:bookmarks_count).search(params[:keyword])
    @reviews = Article.joins(:comments).
      search(params[:keyword]).
      order(Arel.sql("AVG(comments.rate) DESC")).
      group(Arel.sql("comments.article_id"))
    @follow_articles = Article.where(user_id: [current_user.following_ids]).
      order(created_at: "desc").
      page(params[:page]).per(10)
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path, alert: "ご利用誠にありがとうございました。"
  end
end
