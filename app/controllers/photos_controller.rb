class PhotosController < ApplicationController

  def create
    @photo = Photo.new(photo_params)
    unless params[:url] == ""
      @photo.photo_from_url(params[:url])
    end
    if @photo.save
      flash[:success] = "Photo Added to User"
    else
      flash[:error] = "Photo saving unsuccessful"
    end
    redirect_to new_user_photo_path(@photo.user)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:photo, :user_id, :url)
  end

  def get_user
    User.find(params[:user_id])
  end
  helper_method :get_user
end
