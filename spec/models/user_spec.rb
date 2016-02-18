require 'rails_helper'
describe User do

  let(:user){build(:user)}
  let(:profile){create(:profile)}
  let(:new_user){create(:user, :email => 'Foo@mail.com')}

  context 'Validations' do
    it 'is valid with default attributes' do
      expect(user).to be_valid
    end

    it 'is not valid with a password too short' do
      inv_user = build(:user, :password => "foo")
      expect(inv_user).to_not be_valid
    end

    it 'is not valid with a password too long' do
      inv_user = build(:user, :password => '123456789012345678901')
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

  describe "Friending Associations" do

    it "has many initiated friendings" do
      expect(user).to respond_to(:initiated_friendings)
    end

    it "has many friended users" do
      user.friended_users += [new_user]
      expect(user).to respond_to(:friended_users)
      expect(user.friended_users.first.id).to eq(new_user.id)
    end

    it "has many recieved friendings" do
      expect(user).to respond_to(:recieved_friendings)
    end

    it "has many users friended by" do
      expect(user).to respond_to(:users_friended_by)
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
      profile.user.users_friended_by = create_list(:user, num_friends)
      profile.user.save!
    end

    it "returns the number of pending invites - pending_invites" do
      expect(profile.user.pending_invites.count).to eq(num_friends)
    end

    it "returns the number of pending invites - invite_count" do
      expect(profile.user.invite_count).to eq(num_friends)
    end
  end

  describe '#hometown? - empty' do

    it 'returns Hometown object when profile-hometown is nil' do
      new_profile = build(:profile, :hometown_id => nil)
      new_profile.save!
      expect(new_profile.user.hometown?.is_a?(Hometown)).to eq(true)
    end

    it 'returns empty profile-hometown object when profile-hometown is nil' do
      new_profile = build(:profile, :hometown_id => nil)
      new_profile.save!
      expect(new_profile.user.hometown?.id).to eq(nil)
    end
  end

  describe '#hometown? - existing' do

    it 'returns Hometown object' do
      expect(profile.user.hometown?.is_a?(Hometown)).to eq(true)
    end

    it 'returns correct id of profile-hometown object when profile-hometown is set' do
      profile.save!
      expect(profile.user.hometown?.id).to_not eq(nil)
    end

  end

  describe "#currently_live? - empty" do


    it 'returns CurrentlyLive object when profile-currently_live is nil' do
      new_profile = build(:profile, :currently_live_id => nil)
      new_profile.save!
      expect(new_profile.user.currently_live?.is_a?(CurrentlyLive)).to eq(true)
    end

    it 'returns empty CurrentlyLive object when profile-currently_live is nil' do
      new_profile = build(:profile, :currently_live_id => nil)
      new_profile.save!
      expect(new_profile.user.currently_live?.id).to eq(nil)
    end
  end

  describe "#currently_live? - existing" do

    it "returns CurrentlyLive object" do
      expect(profile.user.currently_live?.is_a?(CurrentlyLive)).to eq(true)
    end

    it "returns correct id of CurrentlyLive object when profile-currently_live is set" do
      profile.save!
      expect(profile.user.currently_live?.id).to_not eq(nil)
    end

  end

  describe "#friends" do

      it "finds reciprocated friendings" do
        user.save!
        user.friended_users << new_user
        new_user.friended_users << user

        expect(user.friends.length).to eq(1)
        expect(new_user.friends.length).to eq(1)
      end

  end


end
