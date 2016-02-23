class CommentsController < ApplicationController

  def create

    if params[:photo_id]
      @comment = Photo.find(params[:photo_id]).comments.build(comment_params)
    else
      @comment = Post.find(params[:post_id]).comments.build(comment_params)
    end

    if @comment.save
      flash[:success] = "Comment Created"
    else
      flash[:error] = "Comment creation failed"
    end
    redirect_to request.referrer
  end

  def destroy
    if params[:photo_id]
      @comment = Photo.find(params[:photo_id]).comments.find(params[:comment_id])
    else
      @comment = Post.find(params[:post_id]).comments.find(params[:id])
    end

    if @comment.destroy
      flash[:success] = "Comment Deleted"
    else
      flash[:error] = "Couldn't Delete Comment"
    end
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text, :commentable_id, :commentable_type, :user_id)
  end
end
