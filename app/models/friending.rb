class Friending < ActiveRecord::Base

  belongs_to :friend_initiator,
             foreign_key: :friender_id,
             class_name: "User"

  belongs_to :friend_recipient,
             foreign_key: :friend_id,
             class_name: "User"

  validates :friend_id, :uniqueness => { :scope => :friender_id }

end
