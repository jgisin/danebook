require 'rails_helper'

feature 'User accounts' do

  before do
    create(:sex)
    create(:birth_month)
    create(:year)
    visit root_path
  end

  scenario 'add a new user', js: true do

    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'
    fill_in 'Email Address', with: 'foo@bar.com'
    fill_in 'Input Password', with: 'foobar'
    fill_in 'Confirm Your Password', with: 'foobar'

    select('January', :from => 'Month')
    select('1', :from => 'Day')
    select('1998', :from => 'Year')
    choose('Male')

    expect{ click_button 'Sign Up Now' }.to change(User, :count).by(1)
    expect(page).to have_content('User was successfully created.')
  end

  scenario 'login user goes to timeline page' do
    create(:profile)
    sign_in
    expect(page).to have_content("Success! You've successfully signed in")
  end
end

feature 'Timeline' do

  before do
    create(:sex)
    create(:birth_month)
    create(:year)
    create(:state)
    visit root_path
  end

  scenario 'after login users name is displayed' do
    create(:profile)
    sign_in
    expect(page).to have_content(User.first.profile.fullname)
  end

  scenario 'after login users birthday is displayed' do
    prof = create(:profile)
    User.first.profile = prof
    User.first.save!
    sign_in
    expect(page).to have_content(prof.birthday)
  end

  scenario 'logged in user has Edit Profile link' do
    prof = create(:profile)
    User.first.profile = prof
    User.first.save!
    sign_in
    expect(page).to have_content('Edit Profile')
  end

  scenario 'visiting other users page will not show their edit profile link' do
    prof = create(:profile)
    user2 = create(:user, email: 'foo@bloo.com')
    user2.profile = create(:profile, :user => user2)
    User.first.profile = prof
    User.first.save!
    sign_in
    visit user_path(user2)
    expect(page).to_not have_content('Edit Profile')
  end
end

feature 'Edit Profile' do
  before do
    prof = create(:profile)
    User.first.profile = prof
    User.first.save!
    sign_in
  end

  scenario 'Edit Profile saves words to live by' do
    click_on('Edit Profile')
    fill_in 'user_profile_attributes_words_to_live_by', with: 'Something'
    click_on('Update Profile')
    expect(page).to have_content('Something')
  end
end

feature 'Search' do
  before do
    prof = create(:profile)
    User.first.profile = prof
    User.first.save!
    sign_in
  end

  scenario 'Search pulls up list of matches' do
    fill_in 'search', with: 'foo'
    click_on 'Search'
    expect(page).to have_content("Born on #{User.first.profile.birthday}")
  end
end