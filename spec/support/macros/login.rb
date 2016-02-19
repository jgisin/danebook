module Macros
  module Login
    def sign_in
      visit root_path

      fill_in 'email', with: 'foo@bar.com'
      fill_in 'password', with: 'foobar'

      click_button 'Sign In'
    end
  end
end