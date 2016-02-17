require 'rails_helper'

describe Post do

  let(:post){build(:post)}
  let(:profile){build(:profile)}
  let(:num_posts){10}

  context "Validations" do

    it "is valid with default attributes" do
      expect(post).to be_valid
    end

  end

  context "Associations" do

    it "belongs to user" do
      expect(post).to respond_to(:user)
    end

    it "has many comments" do
      expect(post).to respond_to(:comments)
    end

    it "has many likes" do
      expect(post).to respond_to(:likes)
    end

  end

  context "Methods" do
    it "sorted method puts last posts first" do
      profile.user.posts = create_list(:post, num_posts)
      profile.user.save!
      expect(profile.user.posts.sorted.first.id).to eq 10
    end
  end

  context "Validations" do

    it "will not save a post longer than 300 characters" do
      new_post = build(:post, :post_text => "x" * 301)
      expect(new_post).to_not be_valid
    end

    it "will not save an empty post" do
      new_post = build(:post, :post_text => "")
      expect(new_post).to_not be_valid
    end

    it "will not save a post without a user" do
      new_post = build(:post, :user_id => nil)
      expect(new_post).to_not be_valid
    end
  end

end
