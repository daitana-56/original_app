class ReviewsController < ApplicationController
  before_action :require_user_login
  before_action :get_review, only: [:show, :edit, :update, :destroy, :comment]
  
  def show
  end

  def new
    @review = current_user.reviews.build
  end

  def create
    @shop = Shop.find_by(name: params[:review][:name])
    unless @shop
      @shop = Shop.create(name: params[:review][:name])
    end

    @review = current_user.reviews.build(review_params)
    
    if @review.save
      flash[:success] = "お店を投稿しました。"
      redirect_to @review
    else
      flash.now[:danger] = "お店の投稿に失敗しました。"
      render :new
    end
  end

  def edit
    @review.image.cache! unless @review.image.blank?
  end

  def update
    @shop = Shop.find_by(name: params[:review][:name])
    unless @shop
      @shop = Shop.create(name: params[:review][:name])
    end
    
    if @review.update(review_params)
      flash[:success] = "投稿内容を変更しました。"
      redirect_to @review
    else
      flash.now[:danger] = "投稿内容の変更に失敗しました。"
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to user_path(current_user)
  end
  
  def comment
    @comments = @review.comments.order(id: :desc).page(params[:page])
    @comment = current_user.comments.build
  end
  
  private
  
  def review_params
    params.require(:review).permit(:image, :image_cache, :recommend, :genre_id, :content).merge(shop_id: @shop.id)
  end
  
  def get_review
    @review = Review.find(params[:id])    
  end
end
