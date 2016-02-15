class FriendPresenter < UserPresenter

  presents :friend

  def friend_count
    friend.friends.count
  end

  def friend_button
    if h.current_user.users_friended_by.include?(friend)
      h.link_to "Unfriend Me", h.friending_path(friend), method: :delete, class: 'btn btn-primary'
    else
      h.link_to "Delete Invite", h.friending_path(friend), method: :delete, class: 'btn btn-danger'
    end
  end
end