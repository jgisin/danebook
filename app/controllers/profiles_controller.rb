class ProfilesController < ApplicationController

  def set_profile_photo
    current_user.profile.profile_photo_id = params[:photo_id]
    if current_user.profile.save
      flash[:success] = "Profile photo updated"
    else
      flash[:error] = "Could Not Update Profile Photo"
    end
    redirect_to request.referrer
  end

end
