class Shop < ApplicationRecord
  #review参照  
  has_many :reviews
  
  validates :name, presence: true, length: { maximum: 255 }
end