class Like < ActiveRecord::Base
  after_create :add_activity

  belongs_to :likeable, :polymorphic => true
  belongs_to :user

  def add_activity
    act = Activity.new(activity_type: 'Like', activity_id: self.id)
    act.user_id = self.user_id
    act.save
  end

  def post_from_id
    Post.find(self.likeable_id)
  end
end
