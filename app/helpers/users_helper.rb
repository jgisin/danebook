module UsersHelper

  def current_users_page?
    current_user.id == params[:id].to_i
  end

end
