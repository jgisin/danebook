class Photo < ActiveRecord::Base

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
end
