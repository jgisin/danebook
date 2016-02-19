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
    click_on 'Sign Up Now'
    # expect{ click_button 'Sign Up Now' }.to change(User, :count).by(1)
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
    default_sign_in
    expect(page).to have_content(User.first.profile.birthday)
  end

  scenario 'logged in user has Edit Profile link' do
    default_sign_in
    expect(page).to have_content('Edit Profile')
  end

  scenario 'visiting other users page will not show their edit profile link' do
    default_sign_in
    user2 = create(:user, email: 'foo@bloo.com')
    user2.profile = create(:profile, :user => user2)
    visit user_path(user2)
    expect(page).to_not have_content('Edit Profile')
  end
end

feature 'Edit Profile' do
  before do
    default_sign_in
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
    default_sign_in
  end

  scenario 'Search pulls up list of matches' do
    fill_in 'search', with: 'foo'
    click_on 'Search'
    expect(page).to have_content("Born on #{User.first.profile.birthday}")
  end
end

feature 'Post' do

  before do
    default_sign_in
  end

  scenario 'User can post to their own timeline' do
    user_post
    expect(page).to have_content('Test Post')
  end

  scenario 'User can delete a post they created', js: true do
    user_post
    expect(page).to have_content('Delete Post')
  end

  scenario 'User cannot post to another users timeline' do
    user2 = create(:user, email: 'foo@bltoo.com')
    user2.profile = create(:profile, :user => user2)
    visit user_path(user2)
    expect(page).to_not have_content('post[post_text]')
  end

  scenario 'User can comment on a post', js: true do
    user_post
    expect(page).to have_content('New Comment')
  end

  scenario 'User can delete a comment they created'
  scenario 'User cannot delete a comment they did not create'

  scenario 'User can like a post', js: true do
    user_post
    click_on('Like')
    expect(page).to have_content('Success! Like Created')
  end

  scenario 'User can unlike a post', js: true do
    user_post
    click_on('Like')
    click_on('Unlike')
    expect(page).to have_content('Success! Un-liked')
  end
  scenario 'User can like a comment'
  scenario 'User can unlike a comment'
end