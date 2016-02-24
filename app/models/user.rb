class User < ActiveRecord::Base

  #Authorization
  before_create :generate_token
  after_create :make_profile
  after_create :send_mail
  has_secure_password

  #Associations
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes
  has_many :photos

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

  validates :email, :presence => true,
            :length => {:in => 4..30},
            :allow_nil => false,
            :uniqueness => true

  accepts_nested_attributes_for :profile,
                                :reject_if => :all_blank

  scope :updated, lambda {joins("JOIN posts ON users.id = posts.user_id").order("users.id, posts.created_at DESC").select("users.*, posts.created_at").distinct("users.id").group("users.id, posts.created_at")}

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
      self.profile.build_hometown
    else
      self.profile.hometown
    end
  end

  def currently_live?
    if self.profile.currently_live.nil?
      self.profile.build_currently_live
    else
      self.profile.currently_live
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

  def make_profile
    if self.profile.nil?
      self.build_profile
    end
  end

  def friends
    sql = '
      SELECT DISTINCT users.*
      FROM users
      JOIN friendings
        ON users.id = friendings.friender_id
      JOIN friendings AS reflected_friendings
        ON reflected_friendings.friender_id = friendings.friend_id
      WHERE reflected_friendings.friender_id = ?
      '
      User.find_by_sql([sql,self.id])
  end

  def friend_array
    array = []
    self.friended_users.each do |fu|
      array << fu if self.users_friended_by.include?(fu)
    end
    array
  end

  def self.search(search)
    return nil if search.nil?
    if search.split(' ').length == 1
      self.joins("JOIN profiles ON users.id = profiles.user_id")
          .where("profiles.first_name ILIKE ('%#{search}%') OR profiles.last_name ILIKE ('%#{search}%')")
    elsif search.split(' ').length == 2
      self.joins("JOIN profiles ON users.id = profiles.user_id")
          .where("profiles.first_name ILIKE ('%#{search.split(' ')[0]}%') AND profiles.last_name ILIKE ('%#{search.split(' ')[1]}%')")
    end
  end

  def send_mail
    User.send_welcome_email(self.id)
  end

  class << self
    def send_welcome_email(id)
      user = User.find(id)
      UserMailer.welcome_email(user).deliver!
    end
    handle_asynchronously :send_welcome_email
  end

  def include_friend?(friend_id)
    !!self.friends.include?(User.find(friend_id))
  end

  def friend_ids
    array = self.friend_array.map{|friend| friend.id}
    if array.length > 0
      array
    else
      [0]
    end
  end


end
