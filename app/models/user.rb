class User < ActiveRecord::Base

  #Authorization
  before_create :generate_token
  has_secure_password

  #Associations
  has_one :profile
  has_many :posts
  has_many :comments

  #Friending
  #User initiating friendship
  has_many :initiated_friendings, foreign_key: :friender_id,
           class_name: "Friending"

  has_many :friended_users, :through => :initiated_friendings,
           :source => :friend_recipient

  #User recieving friendship
  has_many :recieved_friendings, foreign_key: :friend_id,
           class_name: "Friending"

  has_many :users_friended_by, :through => :recieved_friendings,
           :source => :friend_initiator

  #Validations
  validates :password,
            :length => {:in => 6..20},
            :allow_nil => true

  accepts_nested_attributes_for :profile,
                                :reject_if => :all_blank

  def pending_invites
    self.users_friended_by.map do |invite|
      unless self.initiated_friendings.include?(invite)
        invite
      end
    end
  end

  def invite_count
    count = 0
    self.pending_invites.each do |invite|
      if self.friended_users.include?(invite)
        next
      else
        count += 1
      end
    end
    count
  end

  def hometown?
    if self.profile.hometown.nil?
      return self.profile.build_hometown
    else
      return self.profile.hometown
    end
  end

  def currently_live?
    if self.profile.currently_live.nil?
      return self.profile.build_currently_live
    else
      return self.profile.currently_live
    end
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def friends
    sql = "
      SELECT DISTINCT users.*
      FROM users
      JOIN friendings
        ON users.id = friendings.friender_id
      JOIN friendings AS reflected_friendings
        ON reflected_friendings.friender_id = friendings.friend_id
      WHERE reflected_friendings.friender_id = ?
      "
      User.find_by_sql([sql,self.id])
  end

end
