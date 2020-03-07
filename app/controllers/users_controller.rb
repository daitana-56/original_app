class UsersController < ApplicationController
  before_action :require_user_login, only: [:index, :show, :edit, :update, :destroy, :followings, :followers, :likes]
  before_action :get_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page])
  end

  def show
    @reviews = @user.reviews.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザ登録完了しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "ユーザ登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:success] = "アカウント設定を完了しました。"
        redirect_to @user
      else
        flash.now[:danger] = "アカウントの設定に失敗しました。"
        render :edit
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    if @user == current_user
      @user.destroy
      flash[:success] = "ユーザアカウントを削除しました。"
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  
  def followings
    @followings = @user.followings.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def likes
    @likes = @user.liking.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :birthday, :password, :password_confirmation, :image, :content)
  end
  
  def get_user
    @user = User.find(params[:id])
  end
end
