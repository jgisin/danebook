FactoryGirl.define do

  factory :user do
    sequence(:username){|n| "Foo#{n}"}
    email {"#{username}@bar.com"}
    password "foobar"
  end

  factory :post do
    post_text "Foo Post"
    user
  end

  factory :comment do
    comment_text "Foo Comment"
    user
  end

  factory :like do
    user
  end

  factory :friending do

  end

  factory :profile do
    first_name "Foo"
    last_name "Bar"
    birth_month_id 6
    year_id 50
    birth_day 16
    sex
    college_id 10
    hometown
    currently_live
    telephone "1234567"
    user
  end

  factory :sex do
    name "Male"
  end

  factory :birth_month do
    month "January"
    abbr "Jan"
  end

  factory :hometown do
    city "Aurora"
    state_id 5
  end

  factory :currently_live do
    city "Denver"
    state_id 5
  end

  factory :year do
    year 1998
  end

  factory :college do
    name "Viking Code School"
  end


end
