class Profile < ActiveRecord::Base

  belongs_to :user
  belongs_to :sex
  belongs_to :birth_month
  belongs_to :year
  belongs_to :college
  belongs_to :hometown
  belongs_to :currently_live

  accepts_nested_attributes_for :hometown,
                                :reject_if => :all_blank

accepts_nested_attributes_for :currently_live,
                              :reject_if => :all_blank

  def birthday
    "#{self.birth_month.month} #{self.birth_day}, #{self.year.year}"
  end

  def home
    if self.hometown.nil? == false 
      "#{self.hometown.city}, #{self.hometown.state.name}"
    else
      "N/A"
    end
  end

  def live
    if self.currently_live.city.nil? == false && self.currently_live.state.nil? == false
      "#{self.currently_live.city}, #{self.currently_live.state.name}"
    else
      "N/A"
    end
  end

  def fullname
    "#{self.first_name} #{self.last_name}"
  end
end
