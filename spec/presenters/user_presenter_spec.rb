require 'rails_helper'

describe UserPresenter do
  let(:user){create(:user, :default)}
  let(:profile){create(:profile, user: user)}
  let(:view){ ActionView::Base.new}
  let(:presenter){UserPresenter.new(profile.user, view)}

  describe '#user_college' do

    it 'returns users college' do
      expect(presenter.user_college).to eq(profile.college.name)
    end

    it 'returns N/A if college is nil' do
      profile.college_id = nil
      profile.save
      expect(presenter.user_college).to eq('N/A')
    end

  end

  describe '#birthday' do

    it 'returns users birthday' do
      expect(presenter.birthday).to eq(profile.birthday)
    end

    it 'returns N/A if birthday is nil' do
      profile.birth_month = nil
      profile.save
      expect(presenter.birthday).to eq('N/A')
    end

  end

  describe '#home' do

    it 'returns users hometown' do
      expect(presenter.home).to eq(profile.home)
    end

    it 'returns N/A if birthday is nil' do
      profile.hometown_id = nil
      profile.save
      expect(presenter.home).to eq('N/A')
    end

  end

  describe '#live' do

    it 'returns users currently live' do
      expect(presenter.live).to eq(profile.live)
    end

    it 'returns N/A if currently live is nil' do
      profile.currently_live_id = nil
      profile.save
      expect(presenter.live).to eq('N/A')
    end

  end

  describe '#fullname' do

    it 'returns users full name' do
      expect(presenter.fullname).to eq("#{profile.first_name} #{profile.last_name}")
    end
  end

  describe '#friend?' do

   context 'visiting your own page' do

      before do

        def view.current_user
        end
        allow(view).to receive(:current_user){profile.user}

        def view.get_user
        end
        allow(view).to receive(:get_user){profile.user}

      end

     it 'returns false when you are on your own page' do
       expect(presenter.friend?).to eq(false)
     end
   end

   context 'visiting your someone elses page' do
     let(:new_user){create(:user)}
     let(:new_profile){create(:profile, user: new_user)}

     before do

       def view.current_user
       end
       allow(view).to receive(:current_user){profile.user}

       def view.get_user
       end
       allow(view).to receive(:get_user){new_profile.user}

     end

     it 'returns true when you are visiting another users page' do
       expect(presenter.friend?).to eq(true)
     end
   end
  end

  describe '#unfriend?' do
    let(:new_user){create(:user)}
    let(:new_profile){create(:profile, user: new_user)}

    before do

      def view.current_user
      end
      allow(view).to receive(:current_user){profile.user}

      def view.get_user
      end
      allow(view).to receive(:get_user){new_profile.user}

    end

    it 'returns false if current user has not friended get user' do
      expect(presenter.unfriend?).to eq(false)
    end

    it 'returns true if current user has friended get user ' do
      user.friended_users << new_user
      expect(presenter.unfriend?).to eq(true)
    end
  end
end