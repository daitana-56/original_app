class User < ApplicationRecord
  #email設定
  before_save { self.email.downcase! }
  #image設定
  mount_uploader :image, ImageUploader
  
  #バリデーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8, maximum: 20 },
                      format: { with: /\A[\w\-]+\z/ } 
  validates :birthday, presence: true
  validate :birthday_check
  
  #セキュリティ設定
  has_secure_password  
  
  #review参照
  has_many :reviews, dependent: :destroy
  
  #comment参照
  has_many :comments, dependent: :destroy
  
  #relationship参照
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  #like参照
  has_many :likes, dependent: :destroy
  has_many :liking, through: :likes, source: :review
  
  #フォロー/アンフォロー用メソッド
  def follow(user)
    unless self == user
      self.relationships.find_or_create_by(follow_id: user.id)
    end
  end
  
  def unfollow(user)
    relationship = self.relationships.find_by(follow_id: user.id)
    relationship.destroy if relationship
  end
  
  def following?(user)
    self.followings.include?(user)
  end
  
  #お気に入り
  def like(review)
    self.likes.find_or_create_by(review_id: review.id)
  end
  
  def unlike(review)
    like = self.likes.find_by(review_id: review.id)
    like.destroy if like
  end
  
  def liking?(review)
    self.liking.include?(review)
  end

  private
  
  #生年月日確認用メソッド
  def birthday_check
    if birthday.nil? || birthday > Date.today
      errors.add(:birthday, 'は無効な日付です。')
    end
  end

end
