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

end
