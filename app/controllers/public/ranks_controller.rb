class Public::RanksController < ApplicationController

  def rank
    @today_user_post_ranks = User.where(id: Article.group(:user_id).where(created_at: Time.current.all_day).order('count(user_id) desc').limit(10).pluck(:user_id))
    @month_user_post_ranks = User.where(id: Article.group(:user_id).where(created_at: Time.current.all_month).order('count(user_id) desc').limit(10).pluck(:user_id))
    @week_user_post_ranks  = User.where(id: Article.group(:user_id).where(created_at: Time.current.all_week).order('count(user_id) desc').limit(10).pluck(:user_id))
  end
end
