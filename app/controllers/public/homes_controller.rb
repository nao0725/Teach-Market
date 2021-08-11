class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all.page(params[:page]).per(3)
  end

  def help
  end

end
