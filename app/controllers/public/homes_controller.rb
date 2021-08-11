class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.page(params[:page]).per(3)
  end

  def help
  end

end
