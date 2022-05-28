class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #フォロー、フォロワーの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships,class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower


  has_one_attached :profile_image


  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローしているか確認する処理
  def following?(user)
    followings.include?(user)
  end

 #プロフィール画像
  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  #ゲストログイン用
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  #退会後ログイン不可の記述
  def active_for_authentication?
    super && (is_deleted == false)
  end

  #検索方法分岐
  def self.looks(search, word)
    @user = User.where("name LIKE?","%#{word}%")
  end
end
