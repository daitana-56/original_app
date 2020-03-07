class Genre < ApplicationRecord
  #review参照
  has_many :reviews
end
