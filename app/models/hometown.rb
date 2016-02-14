class Hometown < ActiveRecord::Base

  has_many :profiles
  belongs_to :state
end
