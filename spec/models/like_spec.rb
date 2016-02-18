require 'rails_helper'
describe Like do
  let(:like){build(:like)}

  context "Associations" do
    it "belongs to user" do
      expect(like).to respond_to(:user)
    end
  end

  it "describes polymorphic like tests"

end
