class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all.page(params[:page]).per(10)
    @bookmarks = Article.find(Bookmark.group(:article_id)
                        .order(Arel.sql("count(article_id) desc"))
                        .pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id)
                      .order(Arel.sql("avg(rate) desc"))
                      .pluck(:article_id))
  end

  def help
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
  
  def guest_sign_in
    user = User.find_or_create_by!(email:"guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.nickname = "ゲスト"
    end
    sign_in user
    redirect_to root_path
  end

end
