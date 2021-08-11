class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.page(params[:page]).reverse_order
  end

  def help
  end

end
