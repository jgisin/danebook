module UsersHelper

  def current_users_page?
    current_user.id == params[:id].to_i
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
