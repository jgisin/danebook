class PostPresenter < BasePresenter

  presents :post

  delegate :post_text, :to => :post
  delegate :created_at, :to => :post

  def post_user_show_link
    h.link_to post.user.profile.fullname, h.user_path( post.user)
  end

  def post_liked?
    post.likes.where(:user_id => h.current_user.id).count == 1
  end

  def get_like_post
    post.likes.where(:user_id => h.current_user.id).first
  end

  def post_like_button
    if post_liked?
      return h.link_to "Unlike", h.post_like_path(post, get_like_post), method: :delete
    else
      return h.link_to "Like", h.post_likes_path(post, :user_id => h.current_user.id), method: :post
    end
  end

end
