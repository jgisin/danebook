require 'rails_helper'
describe User do

  let(:user){build(:user)}
  let(:profile){create(:profile)}

  context "Validations" do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "is not valid with a password too short" do
      inv_user = build(:user, :password => "foo")
      expect(inv_user).to_not be_valid
    end

    it "is not valid with a password too long" do
      inv_user = build(:user, :password => "123456789012345678901")
      expect(inv_user).to_not be_valid
    end

    it "is not valid with no email address" do
      inv_user = build(:user, :email => nil)
      expect(inv_user).to_not be_valid
    end


    describe "attributes" do

      context "when saving multiple users" do

        before do
          user.save!
        end

        it "doesn't allow identical email addresses" do
          new_user = build(:user, :email => user.email)
          expect(new_user).to_not be_valid
        end

      end
    end
  end

  describe "User - Post Association" do

    it "responds to posts" do
      expect(user).to respond_to(:posts)
    end
  end

  describe "User - Profile Association" do

    it "responds to profiles" do
      expect(user).to respond_to(:profile)
    end
  end

  describe "User - Comment Association" do

    it "responds to comments" do
      expect(user).to respond_to(:comments)
    end

  end

  describe "Sanity Check" do

    it "doesn't respond to a non-associated model" do
      expect(user).to_not respond_to(:years)
    end

  end

  describe "#pending_invites/#invite_count" do
    let(:num_friends){3}

    before do
      user.users_friended_by = create_list(:user, num_friends)
      user.save!
    end

    it "returns the number of pending invites - pending_invites" do
      expect(user.pending_invites.count).to eq(num_friends)
    end

    it "returns the number of pending invites - invite_count" do
      expect(user.invite_count).to eq(num_friends)
    end
  end

  describe "#hometown? - empty" do

    it "returns Hometown object when profile-hometown is nil" do
      new_profile = build(:profile, :hometown_id => nil)
      new_profile.save!
      expect(new_profile.user.hometown?.is_a?(Hometown)).to eq(true)
    end

    it "returns empty profile-hometown object when profile-hometown is nil" do
      new_profile = build(:profile, :hometown_id => nil)
      new_profile.save!
      expect(new_profile.user.hometown?.id).to eq(nil)
    end
  end

  describe "#hometown? - existing" do

    it "returns Hometown object" do
      expect(profile.user.hometown?.is_a?(Hometown)).to eq(true)
    end

    it "returns correct id of profile-hometown object when profile-hometown is set"

  end

  describe "#currently_live? - empty" do


    it "returns CurrentlyLive object when profile-currently_live is nil" do
      new_profile = build(:profile, :currently_live_id => nil)
      new_profile.save!
      expect(new_profile.user.currently_live?.is_a?(CurrentlyLive)).to eq(true)
    end

    it "returns empty CurrentlyLive object when profile-currently_live is nil" do
      new_profile = build(:profile, :currently_live_id => nil)
      new_profile.save!
      expect(new_profile.user.currently_live?.id).to eq(nil)
    end
  end

  describe "#currently_live? - existing" do

    it "returns CurrentlyLive object" do
      expect(profile.user.currently_live?.is_a?(CurrentlyLive)).to eq(true)
    end

    it "returns correct id of CurrentlyLive object when profile-currently_live is set"

  end


end
