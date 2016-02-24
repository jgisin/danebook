require 'will_paginate/array'

class NewsfeedsController < ApplicationController
  before_action :require_current_user

  def index
    @users = Activity.user_list.select{|act| current_user.friends.include?(act.user_from_id)}
    @activities = Activity.act_list.select{|act| current_user.friends.include?(act.user_from_id)}.paginate(page: params[:page], per_page: 10)
    @display = ['Post', 'Comment', 'Photo']
  end
end
