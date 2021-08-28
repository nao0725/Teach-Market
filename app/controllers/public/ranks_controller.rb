class Public::RanksController < ApplicationController
  def rank
    @today_post_ranks_user = Article.group(:user_id).where(created_at: Time.current.all_day).order('count(user_id) desc').limit(10).pluck(:user_id) # 今日投稿した記事
    @today_ranks = []
    @today_post_ranks_user.each do |user_id|
      @today_ranks.push({
        "user" => User.find(user_id),
        "count" => Article.where(created_at: Time.current.all_day).where(user_id: user_id).count,
      })
    end

    @week_post_ranks_user = Article.group(:user_id).where(created_at: Time.current.all_week).order('count(user_id) desc').limit(10).pluck(:user_id) # 今日投稿した記事
    @week_ranks = []
    @week_post_ranks_user.each do |user_id|
      @week_ranks.push({
        "user" => User.find(user_id),
        "count" => Article.where(created_at: Time.current.all_week).where(user_id: user_id).count,
      })
    end

    @month_post_ranks_user = Article.group(:user_id).where(created_at: Time.current.all_month).order('count(user_id) desc').limit(10).pluck(:user_id) # 今日投稿した記事
    @month_ranks = []
    @month_post_ranks_user.each do |user_id|
      @month_ranks.push({
        "user" => User.find(user_id),
        "count" => Article.where(created_at: Time.current.all_month).where(user_id: user_id).count,
      })
    end
  end
end
