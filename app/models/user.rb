class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:twitter], :authentication_keys => [:nickname]

  # 各モデルとのアソシエーション
  has_many :articles, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  # フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  # フォローを外すメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end
  
  # 既にフォロー済かどうか確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  # SNS認証時に使用
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      name: auth.info.name,
      nickname: auth.info.nickname,
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )

    user
  end

  # プロフィール画像
  attachment :profile_image

  # 退会したユーザーの再ログインを防止
  def active_for_authentication?
    super && (is_valid == true)
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
  validates :name, presence: true, length: { in: 2..10 }, uniqueness: { case_sensitive: false }
  validates :nickname, presence: true, length: { in: 2..10 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, { presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } }

  private

  # SNS認証
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
