class User < ApplicationRecord
  #email設定
  before_save { self.email.downcase!}
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
  
  private
  
  #生年月日確認用メソッド
  def birthday_check
    if birthday.nil? || birthday > Date.today
      errors.add(:birthday, 'は無効な日付です。')
    end
  end
end
