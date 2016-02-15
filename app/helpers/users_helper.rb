module UsersHelper

  def post_liked?(posted)
    posted.likes.where(:user_id => current_user.id).count == 1
  end

  def comment_liked?(posted, comment)
    posted.comments.find(comment.id).likes.where(:user_id => current_user.id).count == 1
  end

  def get_like_comment(posted, comment)
    posted.comments.find(comment.id).likes.where(:user_id => current_user.id)
  end

  def get_like_post(posted)
    posted.likes.where(:user_id => current_user.id).first
  end

  def hometown?
    if @current_user.profile.hometown.nil?
      return @current_user.profile.build_hometown
    else
      return @current_user.profile.hometown
    end
  end

  def currently_live?
    if @current_user.profile.currently_live.nil?
      return @current_user.profile.build_currently_live
    else
      return @current_user.profile.currently_live
    end
  end

  def get_user
    User.find(params[:id].to_i)
  end

  def friend?
    if current_user == get_user || current_user.friended_users.include?(User.find(params[:id].to_i))
      false
    else
      true
    end
  end

  def unfriend?
    current_user.friended_users.include?(User.find(params[:id].to_i))
  end


end
