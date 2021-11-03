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


  # 複数検索できるように設定
  def self.search(search_word)
    Article.joins(:tags).where([
      "articles.title LIKE(?) OR articles.body LIKE(?) OR articles.sub_title LIKE(?) OR tags.tag_name LIKE(?)",
      "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%",
    ]).distinct
  end
  
  #公開ステータスの設定
  enum article_status: {
    "下書きにする": 0,
    "公開する": 1
  }
  

  validates :title, presence: true, length: { in: 2..20 }
  validates :body, presence: true
end
