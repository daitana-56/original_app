class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  #ログイン確認
  def require_user_login
    unless login?
      redirect_to login_url
    end
  end
  
  #カウンタ
  def counts(user)
    @count_reviews = user.reviews.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_liking = user.liking.count
  end
end
