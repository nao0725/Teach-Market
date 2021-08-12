class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all.page(params[:page]).per(3)
    @bookmarks = Article.find(Bookmark.group(:article_id).order("count(article_id) desc").pluck(:article_id))
    @reviews = Article.find(Comment.group(:article_id).order("avg(rate) desc").pluck(:article_id))
  end

  def help
  end

end
