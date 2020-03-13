class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :genre
  
  #image設定
  mount_uploader :image, ImageUploader
  
  validates :image, presence: true
  validates :content, presence: true
  validates :recommend, length: { maximum: 255 }
  
  #comment参照
  has_many :comments, dependent: :destroy
  
  #like参照
  has_many :likes, dependent: :destroy
end
