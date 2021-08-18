class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :authentication_keys => [:nickname]

  # 各モデルとのアソシエーション
  has_many :articles, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
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

  #SNS認証時に使用
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider:auth.provider).first

    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0,20]
        )
    end

    user
  end

  #プロフィール画像で使用
  attachment :profile_image


  # 退会したユーザーの再ログインを防止
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  # ゲストログインの設定
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = "guest"
      user.name = "guest"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # バリデーション
  validates :name, presence: true, length: { minimum: 1 }
  validates :nickname, presence: true, length: { minimum: 1 }, uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
