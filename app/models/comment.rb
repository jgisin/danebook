class Comment < ActiveRecord::Base
  after_create :add_activity

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  has_many :likes, :as => :likeable,
           :dependent => :destroy

  def add_activity
    act = Activity.new(activity_type: 'Comment', activity_id: self.id)
    act.user_id = self.user_id
    act.save
  end

  def post_from_id
    Post.find(self.commentable_id)
  end

  def parent_user
    self.commentable_type.classify.constantize.find(self.commentable_id).user
  end
end
