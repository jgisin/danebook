class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :pending_invites
  before_action :invite_count
  before_action :require_login, :except => [:index, :new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index

  end

  def timeline
    @user = User.find(params[:id])
    @user_post = @user.posts.order("created_at DESC")
    @count = invite_count
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

  def pending_invites
    @invites = []
    current_user.users_friended_by.each do |invite|
      unless current_user.initiated_friendings.include?(invite)
        @invites << invite
      end
    end
    @invites
  end

  def invite_count
    @count = 0
    pending_invites.each do |invite|
      if current_user.friended_users.include?(invite)
        next
      else
        @count += 1
      end
    end
    @count
  end

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
