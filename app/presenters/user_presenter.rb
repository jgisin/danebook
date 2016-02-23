class UserPresenter < BasePresenter

  presents :user
  delegate :email, :to => :user
  delegate :telephone, :to => "user.profile"
  delegate :words_to_live_by, :to => "user.profile"
  delegate :about_me, :to => "user.profile"


  def user_college
    user.profile.college ? user.profile.college.name : "N/A"
  end

  def birthday
    if !user.profile.birth_month.nil?
     "#{user.profile.birth_month.month} #{user.profile.birth_day}, #{user.profile.year.year}"
    else
      "N/A"
    end
  end

  def home
    if !user.profile.hometown.nil?
      "#{user.profile.hometown.city}, #{user.profile.hometown.state.name}"
    else
      "N/A"
    end
  end

  def live
    if !user.profile.currently_live.nil?
      "#{user.profile.currently_live.city}, #{user.profile.currently_live.state.name}"
    else
      "N/A"
    end
  end

  def fullname
    "#{user.profile.first_name} #{user.profile.last_name}"
  end

  def user_show_link
    h.link_to self.fullname, h.user_timeline_path(user)
  end

  def friend?
    !(h.current_user == h.get_user || h.current_user.friended_users.include?(User.find(h.get_user.id)))
  end

  def unfriend?
    h.current_user.friended_users.include?(User.find(h.get_user.id))
  end

  def friend_button
    if friend?
      h.link_to "Add Friend", h.friendings_path(:id => h.params[:id]), method: :post, class: 'btn btn-lg btn-primary'
    elsif unfriend?
      h.link_to "Unfriend Me", h.friending_path(:id => h.params[:id]), method: :delete, class: 'btn btn-lg btn-danger'
    end
  end

  def search_friend_button
    if h.current_user.friended_users.include?(user)
      h.link_to "Unfriend Me", h.friending_path(:id => h.params[:id]), method: :delete, class: 'btn btn-lg btn-warning'
    elsif h.current_user == user
      nil
    else
      h.link_to "Add Friend", h.friendings_path(:id => h.params[:id]), method: :post, class: 'btn btn-lg btn-primary'
    end
  end

  def profile_image
    if h.get_user.profile.profile_photo_id.nil?
      return "<img src='https://unsplash.it/90/70' alt='No img'>".html_safe
    else
      return h.image_tag(Photo.find(h.get_user.profile.profile_photo_id).photo.url(:thumb))
    end
  end

end
