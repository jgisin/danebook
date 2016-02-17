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

  def current_user_like?
    liked = post.likes.select{|like| like.user_id == h.current_user.id}
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
    if post.likes.count < 3
      post.likes.each do |like|
        if like.user_id != h.current_user.id
          like_text += h.link_to(" #{users_name(like.user_id)},", h.user_path(like.user_id))
        end
      end
    elsif post.likes.count >= 3
      if current_user_like?
        like_text += " and #{post.likes.count - 1} others"
      else
        like_text += "#{post.likes.count} others"
      end
    end
    like_text += " like this post"
    if post.likes.count == 0
      like_text = ""
    end
    like_text.html_safe
  end

  def post_like_button
    if post_liked?
      return h.link_to "Unlike", h.post_like_path(post, get_like_post), method: :delete
    else
      return h.link_to "Like", h.post_likes_path(post, :user_id => h.current_user.id), method: :post
    end
  end

end
