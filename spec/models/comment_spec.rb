require 'rails_helper'
describe Comment do

  let(:comment){build(:comment)}

  context "Associations" do

    it "belongs to user" do
      expect(comment).to respond_to(:user)
    end

    it "belongs to commentable" do
      expect(comment).to respond_to(:commentable)
    end

    it "has many likes" do
      expect(comment).to respond_to(:likes)
    end
  end


  it "describes polymorphic comment tests"

end
