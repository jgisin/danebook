module Macros
  module Post
    def user_post
      fill_in 'post[post_text]', with: 'Test Post'
      click_button 'Post'
    end
  end
end