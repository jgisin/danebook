class UserPresenter < BasePresenter

  presents :user
  delegate :email, :to => :user
  delegate :telephone, :to => "user.profile"
  delegate :words_to_live_by, :to => "user.profile"
  delegate :about_me, :to => "user.profile"


  def user_college
    user.profile.college ? user.profile.college.name : "N/A"
  end

  def birthday
    "#{user.profile.birth_month.month} #{user.profile.birth_day}, #{user.profile.year.year}"
  end

  def home
    if user.profile.hometown.nil? == false
      "#{user.profile.hometown.city}, #{user.profile.hometown.state.name}"
    else
      "N/A"
    end
  end

  def live
    if user.profile.currently_live.nil? == false
      "#{user.profile.currently_live.city}, #{user.profile.currently_live.state.name}"
    else
      "N/A"
    end
  end

  def fullname
    "#{user.profile.first_name} #{user.profile.last_name}"
  end

end
