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

  factory :profile do
    first_name "Foo"
    last_name "Bar"
    birth_month_id 6
    year_id 50
    birth_day 16
    sex_id 1
    college_id 10
    hometown_id 15
    currently_live_id 12
    telephone "1234567"
    user
  end

  factory :sex do
    name "Male"
  end

end
