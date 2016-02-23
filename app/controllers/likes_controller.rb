class LikesController < ApplicationController

  def create
    if params[:post_id]
      if params[:comment_id]
        @like = Post.find(params[:post_id]).comments.find(params[:comment_id]).likes.build(user_id: params[:user_id])
      else
        @like = Post.find(params[:post_id]).likes.build(user_id: params[:user_id])
      end
    elsif params[:photo_id]
      if params[:comment_id]
        @like = Photo.find(params[:photo_id]).comments.find(params[:comment_id]).likes.build(user_id: params[:user_id])
      else
        @like = Photo.find(params[:photo_id]).likes.build(user_id: params[:user_id])
      end
    end
    if @like.save
      flash[:success] = 'Like Created'
    else
      flash[:error] = 'Like creation failed'
    end
    redirect_to request.referrer
  end

  def destroy
    if params[:comment_id]
      @like = Post.find(params[:post_id]).comments.find(params[:comment_id]).likes.where(:user_id => current_user.id).first
    else
      @like = Post.find(params[:post_id]).likes.where(:user_id => current_user.id).first
    end
    if @like.destroy
      flash[:success] = 'Un-liked'
    else
      flash[:error] = "Couldn't Unlike"
    end
    redirect_to request.referrer
  end



end
