require 'will_paginate/array'

class NewsfeedsController < ApplicationController
  before_action :require_current_user

  def index
    @users = Activity.user_list(current_user)
    @activities = Activity.act_list.activity_list(current_user).paginate(page: params[:page], per_page: 10)
    @display = ['Post', 'Comment', 'Photo']
  end
end
