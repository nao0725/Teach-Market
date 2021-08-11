class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all.page(params[:page]).per(3).order(params[:sort])
    @bookmark_ranks = Article.find(Bookmark.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
    @review_ranks = Article.find(Comment.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end

  def help
  end

end
