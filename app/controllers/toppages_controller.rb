class ToppagesController < ApplicationController
  before_action :require_user_login, only: [:popular, :likes]
  
  def index
    @reviews = Review.order(id: :desc).page(params[:page])
  end
  
  def populars
    @rank_reivew = Review.find(Like.group(:review_id).order('count(review_id) desc').limit(20).pluck(:review_id))
  end
  
  def likes
    @likes = current_user.liking.order(id: :desc).page(params[:page])
  end
end
