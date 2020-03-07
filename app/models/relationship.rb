class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  #バリデーション
  validates :user_id, uniqueness: { scope: :follow_id }
end
