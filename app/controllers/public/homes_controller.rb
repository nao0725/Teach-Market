class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.where.not(body:nil, title:nil)
  end

  def help
  end

end
