class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 各モデルとのアソシエーション
  has_many :articles, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  # フォローするときのメソッド
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外すメソッド
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # 既にフォロー済かどうか確認するメソッド
  def following?(user)
    followings.include?(user)
  end

  #プロフィール画像で使用
  attachment :profile_image

  # バリデーション
  validates :name, presence: true, length: { minimum: 1 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}


end
