class Article < ApplicationRecord
  belongs_to :user
  has_many :article_tags
  has_many :tags, through: :article_tags, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  # 既にブックマークしていないか確認
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # 複数のタグ付け機能で実装
  def tags_save(tag_list)
    if !tags.nil?
      article_tags_records = ArticleTag.where(article_id: id)
      article_tags_records.destroy_all
    end
    


    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      tags << inspected_tag
    end
  end

  # 星評価の平均値を表示
  def avg_score
    if comments.empty?
      0.0
    else
      comments.average(:rate).round(1)
    end
  end

  # ユーザーの投稿数ランキング
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } # 今週
  scope :created_this_month, -> { where(created_at: time.beginning_of_month..time.end_of_month) } # 前週

  # 複数検索できるように設定
  def self.search(search_word)
    Article.joins(:tags).where([
      "articles.title LIKE(?) OR articles.body LIKE(?) OR articles.sub_title LIKE(?) OR tags.tag_name LIKE(?)",
      "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%",
    ]).distinct
  end

  validates :title, presence: true, length: { in: 2..20 }
  validates :body, presence: true
end
