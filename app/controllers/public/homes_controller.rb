class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all.page(params[:page]).per(3).order(params[:sort])
  end

  def help
  end

end
