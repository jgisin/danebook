class CommentPresenter < BasePresenter

  presents :comment

  delegate :comment_text, :to => :comment
  delegate :created_at, :to => :comment

  def comment_user_show_link
    h.link_to comment.user.profile.fullname, h.user_timeline_path(comment.user)
  end

  def comment_liked?
    comment.likes.where(:user_id => h.current_user.id).count == 1
  end

  def get_like_comment
    comment.likes.where(:user_id => h.current_user.id)
  end

  def comment_like_button(post)
    if comment_liked?
      h.link_to "Unlike", h.post_comment_like_path(post, comment, get_like_comment), method: :delete
    else
      h.link_to "Like", h.post_comment_likes_path(post, comment, :user_id => h.current_user.id), method: :post
    end
  end

  def current_user_like?
    liked = comment.likes.select{|like| like.user_id == h.current_user.id}
    liked.length > 0
  end

  def users_name(id)
    User.find(id).profile.fullname
  end

  def like_text
    like_text = ""
    if current_user_like?
      like_text += h.link_to("You, ", h.user_path(h.current_user))
    end
    if comment.likes.count < 3
      comment.likes.each do |like|
        if like.user_id != h.current_user.id
          like_text += h.link_to(" #{users_name(like.user_id)},", h.user_path(like.user_id))
        end
      end
    elsif comment.likes.count >= 3
      if current_user_like?
        like_text += " and #{comment.likes.count - 1} other users"
      else
        like_text += "#{comment.likes.count} other users"
      end
    end
    like_text += " like this comment"
    if comment.likes.count == 0
      like_text = ""
    end
    like_text.html_safe
  end

end
