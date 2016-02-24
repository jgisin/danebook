class Photo < ActiveRecord::Base
  after_create :add_activity

  has_attached_file :photo, :styles => { :medium => "225x225", :thumb => "100x100", :jumbo => "800x400" }, :s3_host_name => 's3-us-west-2.amazonaws.com'

  belongs_to :user

  has_one :profile, :dependent => :nullify

  has_many :comments, :as => :commentable,
           :dependent => :destroy

  has_many :likes, :as => :likeable,
           :dependent => :destroy

  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  def photo_from_url(url)
    self.photo = open(url)
  end

  def add_activity
    act = Activity.new(activity_type: 'Photo', activity_id: self.id)
    act.user_id = self.user_id
    act.save
  end

end