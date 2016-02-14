# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# A list of states.
State.delete_all
puts "Deleted all states"
STATES = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

def generate_state(state)
  state = State.new({:name => state})
  state.save
end

STATES.each do |state|
  generate_state(state)
end
puts "Created 50 states"

20.times do
  Hometown.create( :city => Faker::Address.city, :state_id => rand(1..50) )
  College.create(name: Faker::University.name)
  CurrentlyLive.create(city: Faker::Address.city, :state_id => rand(1..50) )
end
puts "Created 20 colleges and hometowns"

BirthMonth.delete_all
puts "Deleted Birth Months"

BirthMonth.create([{month: "January", abbr: "Jan"},
                   {month: "February", abbr: "Feb"},
                   {month: "March", abbr: "Mar"},
                   {month: "April", abbr: "Apr"},
                   {month: "May", abbr: "May"},
                   {month: "June", abbr: "Jun"},
                   {month: "July", abbr: "Jul"},
                   {month: "August", abbr: "Aug"},
                   {month: "September", abbr: "Sep"},
                   {month: "October", abbr: "Oct"},
                   {month: "November", abbr: "Nov"},
                   {month: "December", abbr: "Dec"}])
puts "Created Birth Months"

Sex.delete_all
puts "Deleted Sexes"
Sex.create([{name: "Male"}, {name: "Female"}])
puts "Created sexes"

Year.delete_all
puts "Deleted Years"

(1940..1998).to_a.each do |year|
  Year.create(year: year)
end
puts "Created Years"

User.delete_all
Profile.delete_all
puts "Deleted all users and profiles"

100.times do
  user = Faker::Name.name.split(" ")
  usr = User.create(username: Faker::Internet.user_name, email: Faker::Internet.email(user[0]), password: "foobar")
  usr.build_profile(first_name: user[0], last_name: user[1], sex_id: rand(1..2), birth_day: rand(1..31), birth_month_id: rand(1..12), year_id: rand(1..59), telephone: Faker::PhoneNumber.phone_number, words_to_live_by: Faker::Hipster.sentence(3), about_me: Faker::Hipster.paragraph(2))
  usr.profile.hometown_id = rand(1..20)
  usr.profile.college_id = rand(1..20)
  usr.profile.currently_live_id = rand(1..20)
  usr.save
  rand(1..5).times do
    post = usr.posts.build(post_text: Faker::Hipster.sentence(rand(1..4)))
    post.save
    rand(5).times do
      c = post.comments.build(comment_text: Faker::Hipster.sentence(rand(1..4)), user_id: rand(1..100))
      c.save
    end
  end
end

puts "Created 100 users and profiles with posts and comments"
