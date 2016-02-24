class FriendPresenter < UserPresenter

  presents :friend

  def friend_count
    friend.friend_array.count
  end

  def unfriend_button
    if h.current_user.users_friended_by.include?(friend)
      h.link_to "Unfriend Me", h.friending_path(friend), method: :delete, class: 'btn btn-primary'
    else
      h.link_to "Delete Invite", h.friending_path(friend), method: :delete, class: 'btn btn-danger'
    end
  end
end
