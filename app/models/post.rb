class Post < ActiveRecord::Base

  belongs_to :user

  has_many :comments, :as => :commentable,
           :dependent => :destroy

  has_many :likes, :as => :likeable,
           :dependent => :destroy

  scope :sorted, lambda {order("posts DESC")}
end
