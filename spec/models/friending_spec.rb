require 'rails_helper'
describe Friending do

  let(:friend){build(:friending)}
  let(:user){build(:user)}

  context "Associations" do

    it "belongs to friend initiator" do
      expect(friend).to respond_to(:friend_initiator)
    end

    it "belongs to friend recipient" do
      expect(friend).to respond_to(:friend_recipient)
    end


  end

end
