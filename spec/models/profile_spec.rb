require 'rails_helper'
describe Profile do

  let(:user){build(:user)}
  let(:profile){build(:profile)}


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
        profile.user_id = 1234
        expect(profile).to_not be_valid
      end

    end


    describe "Sex" do

      specify "linking a valid gender succeeds" do
        sex = create(:sex)
        profile.sex = sex
        expect(profile).to be_valid
      end

    end


    describe "Birth Month" do

      specify "linking a valid birth_month succeeds" do
        month = create(:birth_month)
        profile.birth_month = month
        expect(profile).to be_valid
      end

    end

    describe "Year" do

      specify "linking a valid year succeeds" do
        year = create(:year)
        profile.year = year
        expect(profile).to be_valid
      end

    end

    describe "Hometown" do

      specify "linking a valid hometown succeeds" do
        home = create(:hometown)
        profile.hometown = home
        expect(profile).to be_valid
      end

    end

    describe "CurrentlyLive" do

      specify "linking a valid currently lives succeeds" do
        live = create(:currently_live)
        profile.currently_live = live
        expect(profile).to be_valid
      end

    end

    describe "College" do

      specify "linking a valid college succeeds" do
        college = create(:college)
        profile.college = college
        expect(profile).to be_valid
      end

    end
  end

end
