class Post < ActiveRecord::Base
  after_create :add_activity

  belongs_to :user

  has_many :comments, :as => :commentable,
           :dependent => :destroy

  has_many :likes, :as => :likeable,
           :dependent => :destroy

  scope :sorted, lambda {order("posts DESC")}
  scope :updated, lambda {select("posts.user_id, MAX(posts.created_at) as recentpost").group("posts.user_id").order("recentpost DESC")}


  validates :post_text, presence: true, length: { maximum: 300 }
  validates :user, presence: true

  # def self.sorted_posts
  #   sql = 'SELECT orig_post.user_id, orig_post.created_at
  #          from posts orig_post
  #          INNER JOIN (
  #          SELECT posts.user_id, MAX(posts.created_at) as recentpost
  #          FROM posts
  #          GROUP BY posts.user_id
  #          ) AS subpost
  #          ON orig_post.user_id = subpost.user_id AND orig_post.created_at = subpost.recentpost
  #          ORDER BY orig_post.created_at DESC'
  #
  #   Post.find_by_sql(sql)
  # end

  def add_activity
    act = Activity.new(activity_type: 'Post', activity_id: self.id)
    act.user_id = self.user_id
    act.save
  end

end