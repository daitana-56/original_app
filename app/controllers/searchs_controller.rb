class SearchsController < ApplicationController
  before_action :require_user_login
  
  def search
    if params[:search].present?
      @users = User.where('name LIKE?', "%#{params[:search]}%").order(id: :desc).page(params[:page])
    else
      @users = User.none
    end
  end
  
  def shopsearch
    if params[:search].present?
      @reviews = Review.where(shop_id: Shop.where('name LIKE?', "%#{params[:search]}%")).order(id: :desc).page(params[:page])
    else
      @reviews = Review.none
    end
  end
  
  def genresearch
    if params[:search].present?
      @reviews = Review.where(genre_id: params[:search]).order(id: :desc).page(params[:page])
    else
      @reviews = Review.none
    end
  end
  
end
