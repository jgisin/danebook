class CommentsController < ApplicationController

  def create
    @comment = Post.find(params[:post_id]).comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment Created"
    else
      flash[:error] = "Comment creation failed"
    end
    redirect_to request.referrer
  end

  def destroy
    @comment = Post.find(params[:post_id]).comments.find(params[:id])
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
