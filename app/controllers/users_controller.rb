class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, :except => [:index, :new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index

  end

  def timeline
    @user = User.find(params[:id])
    @user_post = @user.posts.order("created_at DESC")
  end

  def friends

  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to current_user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to current_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    sign_out
    if current_user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  end

  private

  def set_user
    current_user ? @user = current_user : @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :profile_attributes => [:id,
                                                         :first_name,
                                                         :last_name,
                                                         :birth_day,
                                                         :birth_month_id,
                                                         :sex_id,
                                                         :year_id,
                                                         :telephone,
                                                         :hometown_id,
                                                         :college_id,
                                                         :words_to_live_by,
                                                         :about_me,
                                                         :hometown_attributes => [:city, :state_id, :id],
                                                         :currently_live_attributes => [:city, :state_id, :id]])
  end
end
