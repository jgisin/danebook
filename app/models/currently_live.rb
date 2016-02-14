class CurrentlyLive < ActiveRecord::Base

  has_many :profiles
  belongs_to :state
end
