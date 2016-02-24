class Friending < ActiveRecord::Base


  belongs_to :friend_initiator,
             foreign_key: :friender_id,
             class_name: "User"

  belongs_to :friend_recipient,
             foreign_key: :friend_id,
             class_name: "User"

  validates :friend_id, :uniqueness => { :scope => :friender_id }

  def add_activity
    act = Activity.new(activity_type: 'Friending', activity_id: self.id)
    act.user_id = self.user_id
    act.save
  end

end
