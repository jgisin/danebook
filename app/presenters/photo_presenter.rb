class PhotoPresenter < BasePresenter

  presents :photo

  delegate :photo_content_type, :to => :photo
  delegate :created_at, :to => :photo

  def photo_user_show_link
    h.link_to photo.user.profile.fullname, h.user_timeline_path(photo.user)
  end

  def photo_liked?
    photo.likes.where(:user_id => h.current_user.id).count == 1
  end

  def get_like_photo
    photo.likes.where(:user_id => h.current_user.id)
  end

  def photo_like_button(photo)
    if photo_liked?
      h.link_to "Unlike", h.user_photo_like_path(h.get_user, photo, get_like_photo), method: :delete
    else
      h.link_to "Like", h.user_photo_likes_path(h.get_user, photo), method: :post
    end
  end

  def photo_comment_like_button(photo, comment)
    if photo_liked?
      h.link_to "Unlike", h.user_photo_comment_like_path(h.current_user, photo, comment, get_like_photo), method: :delete
    else
      h.link_to "Like", h.user_photo_comment_likes_path(h.current_user.id, photo.id, comment_id: comment.id), method: :post
    end
  end

  def current_user_like?
    liked = photo.likes.select{|like| like.user_id == h.current_user.id}
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
    if photo.likes.count < 3
      photo.likes.each do |like|
        if like.user_id != h.current_user.id
          like_text += h.link_to(" #{users_name(like.user_id)},", h.user_path(like.user_id))
        end
      end
    elsif photo.likes.count >= 3
      if current_user_like?
        like_text += " and #{photo.likes.count - 1} other users"
      else
        like_text += "#{photo.likes.count} other users"
      end
    end
    like_text += " like this photo"
    if photo.likes.count == 0
      like_text = ""
    end
    like_text.html_safe
  end

  def profile_image
    if h.get_user.profile.profile_photo_id.nil?
      return "<img src='https://unsplash.it/90/70' alt='No img'>".html_safe
    else
      return h.image_tag(Photo.find(h.get_user.profile.profile_photo_id).photo.url(:thumb))
    end
  end

  def profile_image_page
    if photo.user.profile.profile_photo_id.nil?
      return "<img src='https://unsplash.it/90/70' alt='No img'>".html_safe
    else
      return h.image_tag(Photo.find(photo.user.profile.profile_photo_id).photo.url(:thumb))
    end
  end

end