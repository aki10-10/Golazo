class Blog < ApplicationRecord
  has_one_attached :image

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  # タグのリレーションのみ記載
  has_many :blog_tags,dependent: :destroy
  has_many :tags,through: :blog_tags

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def get_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize: size).processed
  end

  # 検索方法
  def self.looks(search, word)
    @blog = Blog.where("title LIKE?","%#{word}%")
  end

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete  Tag.find_by(name: old) #デリーとメソッドの記述
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end
end
