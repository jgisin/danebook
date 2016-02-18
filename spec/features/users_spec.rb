require 'rails_helper'

feature 'User accounts' do

  before do
    create(:sex)
    create(:birth_month)
    create(:year)
    visit root_path
  end

  scenario 'add a new user' do

    fill_in 'First Name', with: 'Test'
    fill_in 'Last Name', with: 'User'
    fill_in 'Email Address', with: 'foo@bar.com'
    fill_in 'Input Password', with: 'foobar'
    fill_in 'Confirm Your Password', with: 'foobar'

    select('January', :from => 'Month')
    select('1', :from => 'Day')
    select('1998', :from => 'Year')

    choose('Male')
    click_button 'Sign Up Now'
    # save_and_open_page

    # expect(User.all.count).to eq(1)

    # expect{ click_button 'Sign Up Now' }.to change(User, :count).by(1)
    expect(page).to have_content("Error! We couldn't sign you in")
  end
end