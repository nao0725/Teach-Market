class Public::HomesController < ApplicationController

  def top
  end

  def home
    @articles = Article.all
    # @tag = @articles.tag_name
  end

  def help
  end

end
