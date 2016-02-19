FactoryGirl.define do

  factory :user do
    sequence(:username){|n| "Foo#{n}"}
    email {"#{username}@bar.com"}
    password 'foobar'

    trait :default do
      email 'foo@bar.com'
      password 'foobar'
    end
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
    first_name 'Foo'
    last_name 'Bar'
    birth_month
    year
    birth_day 1
    sex
    college
    hometown
    currently_live
    telephone '1234567'
    association :user, :factory => [:user, :default]
  end

  factory :sex do
    name 'Male'
  end

  factory :birth_month do
    month 'January'
    abbr 'Jan'
  end

  factory :hometown do
    city 'Aurora'
    state
  end

  factory :currently_live do
    city 'Denver'
    state
  end

  factory :year do
    year 1998
  end

  factory :college do
    name 'Viking Code School'
  end

  factory :state do
    name 'Colorado'
  end

end
