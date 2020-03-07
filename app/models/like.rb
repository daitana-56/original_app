class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  
  #バリデーション
  validates :user_id, uniqueness: { scope: :review_id }
end
