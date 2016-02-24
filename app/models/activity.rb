class Activity < ActiveRecord::Base

  #scope :user_list, lambda {select("activities.user_id, MAX(activities.created_at) as recentact").group("activities.user_id").order("recentact DESC")}
  scope :act_list, lambda {select("activities.*, MAX(activities.created_at) as recentact").group("activities.user_id, activities.id").order("recentact DESC")}



  def user_from_id
    User.find(self.user_id)
  end

  def post_from_id
    Post.find(self.activity_id)
  end

  def comment_from_id
    Comment.find(self.activity_id)
  end

  def like_from_id
    Like.find(self.activity_id)
  end

  def photo_from_id
    Photo.find(self.activity_id)
  end

  def self.activity_list(current_user)
    self.select("activities.*, MAX(activities.created_at) as recentact").group("activities.user_id, activities.id").order("recentact DESC").where("activities.user_id IN (#{current_user.friend_ids.join(', ')}, #{current_user.id})")
  end

  def self.user_list(current_user)
    self.select("activities.user_id, MAX(activities.created_at) as recentact").group("activities.user_id").order("recentact DESC").where("activities.user_id IN (#{current_user.friend_ids.join(', ')})")
  end
  # def self.scope_friends
  #   self.select do |act|
  #     act.user_from_id.friends.include?(act.user_from_id)
  #   end
  # end
end
