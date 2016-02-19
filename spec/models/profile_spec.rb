require 'rails_helper'
describe Profile do

  let(:user){build(:user)}
  let(:profile){build(:profile)}


  context 'Validations' do

    it 'is valid with default attributes' do
      expect(profile).to be_valid
    end

  end

  context 'Associations' do

    before do
      profile.save!
    end

    describe 'Users' do

      specify 'belongs to user' do
        user = create(:user)
        profile.user = user
        expect(profile).to be_valid
      end


    end


    describe 'Sex' do

      specify 'belongs to sex' do
        sex = create(:sex)
        profile.sex = sex
        expect(profile).to be_valid
      end

    end


    describe 'Birth Month' do

      specify 'belongs to birth month' do
        month = create(:birth_month)
        profile.birth_month = month
        expect(profile).to be_valid
      end

    end

    describe 'Year' do

      specify 'belongs to year' do
        year = create(:year)
        profile.year = year
        expect(profile).to be_valid
      end

    end

    describe 'Hometown' do

      specify 'belongs to hometown' do
        home = create(:hometown)
        profile.hometown = home
        expect(profile).to be_valid
      end

    end

    describe 'CurrentlyLive' do

      specify 'belongs to currently_live' do
        live = create(:currently_live)
        profile.currently_live = live
        expect(profile).to be_valid
      end

    end

    describe 'College' do

      specify 'belongs to college' do
        college = create(:college)
        profile.college = college
        expect(profile).to be_valid
      end

    end
  end

end
