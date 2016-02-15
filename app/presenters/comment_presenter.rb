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

end
