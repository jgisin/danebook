class FriendingsController < ApplicationController

  def create
    friend_recipient = User.find(params[:id])
    if current_user.friended_users << friend_recipient
      flash[:success] = "Sent friend request"
    else
      flash[:error] = "Failed to send friend request"
    end
    redirect_to user_timeline_path(friend_recipient)
  end

  def destroy
    if User.find(params[:id]) == current_user
      current_user.users_friended_by.delete(User.find(params[:invite]))
      flash[:success] = "Denied Friend Request"
      redirect_to request.referrer
    else
      unfriended_user = User.find(params[:id])
      current_user.friended_users.delete(unfriended_user)
      flash[:success] = "Successfully unfriended"
      redirect_to request.referrer
    end
  end

  def deny

  end


end
