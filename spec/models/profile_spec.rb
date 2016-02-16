require 'rails_helper'
describe Profile do

  let(:user){build(:user)}
  let(:profile){build(:profile)}
  let(:sex){buid(:sex)}

  context "Validations" do

    it "is valid with default attributes" do
      expect(profile).to be_valid
    end

  end

  context "Associations" do

    before do
      profile.save!
    end

    describe "Users" do
      specify "linking a valid user succeeds" do
        user = create(:user)
        profile.user = user
        expect(profile).to be_valid
      end

      specify "linking an invalid user does not succeed" do
        profile.user_id = 1239087
        expect(profile).to_not be_valid
      end
    end

    describe "Sex" do

      specify "linking a valid gender succeeds" do
        sex = create(:sex)
        profile.sex = sex
        expect(profile).to be_valid
      end

      specify "linking an invalid gender does not succeed" 

    end
  end

end
