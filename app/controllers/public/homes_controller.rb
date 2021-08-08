class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all
  end

  def help
  end

end
