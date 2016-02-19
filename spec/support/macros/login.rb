module Macros
  module Login
    def sign_in
      visit root_path

      fill_in 'email', with: 'foo@bar.com'
      fill_in 'password', with: 'foobar'

      click_button 'Sign In'
    end

    def default_sign_in
      prof = create(:profile)
      User.first.profile = prof
      User.first.save!
      sign_in
    end
  end
end