class Article < ApplicationRecord
  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy


  # 既にブックマークしていないか確認
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
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
  enum article_status: { draft: 0, published: 1 }

  #ステータスを変更するボタンの設定
  def status_btn
    if draft?
      "公開する"
    else
      "下書きに戻す"
    end
  end

  def update_status!
    if draft?
      published!
    else
      draft!
    end
  end

  validates :title, presence: true, length: { in: 2..20 }
  validates :body, presence: true
  validates :article_status, inclusion: { in: Article.article_statuses.keys }
end
