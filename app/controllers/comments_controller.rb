class CommentsController < ApplicationController
  before_action :require_user_login
  
  def create
    comment = current_user.comments.build(content: params[:comment][:content], review_id: params[:review_id])
    
    if comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to comment_review_path(comment.review_id)
    else
      @review = Review.find(params[:review_id])
      @comments = @review.comments.order(id: :desc).page(params[:page])
      @comment = comment
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'reviews/comment'
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])
    review = comment.review
    
    comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to  comment_review_path(review)
  end
  
end
