class Public::RanksController < ApplicationController
  
  def rank
    @user_post_ranks = User.where(id: Article.group(:user_id).order("count(user_id) desc").pluck(:user_id))
  end
end
