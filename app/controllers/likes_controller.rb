class LikesController < ApplicationController
  before_action :require_user_login
  
  def create
    review = Review.find(params[:review_id])
    current_user.like(review)
    
    flash[:success] = 'お気に入り登録しました。'
    redirect_to review
  end

  def destroy
    review = Review.find(params[:review_id])
    current_user.unlike(review)
    
    flash[:success] = 'お気に入り解除しました。'
    redirect_to review
  end
end
