class PostsController < ApplicationController
  before_action :require_login, :except => [:index, :new, :create]
  before_action :require_current_user, :only => [:edit, :update]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post Created"
    else
      flash[:error] = "Post Not Created"
    end
    redirect_to user_timeline_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post Deleted"
    else
      flash[:error] = "Post Not Deleted"
    end
    redirect_to user_timeline_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:post_text)
  end



end
