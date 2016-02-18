class State < ActiveRecord::Base
  has_many :hometowns
  has_many :currently_live
end
