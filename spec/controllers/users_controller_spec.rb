require 'rails_helper'

describe UsersController do

  describe 'GET #timeline' do
    let(:user){create(:user)}


    context 'authorized' do

      it 'assigns the user from params id' do
        request.cookies["auth_token"] = user.auth_token
        get :timeline, id: user.id
        expect(assigns(:user)).to match user
      end

    end

    context 'not authorized' do

      it 'redirects to root when accessing timeline without authorization' do
        get :timeline, id: user.id
        expect(response).to redirect_to(root_url)
        expect(request.flash[:error]).to_not be_nil
      end

    end

  end

  describe 'GET #show' do
    let(:user){create(:user)}


    context 'authorized' do
      it 'assigns the user from params id' do
        request.cookies["auth_token"] = user.auth_token
        get :show, id: user.id
        expect(assigns(:user)).to match user
      end
    end

    context 'not authorized' do
      it 'redirects to root when accessing about without authorization' do
        get :show, id: user.id
        expect(response).to redirect_to(root_url)
        expect(request.flash[:error]).to_not be_nil
      end
    end
  end

  describe 'POST #create' do
    let(:user){create(:user)}
    let(:sex){create(:sex)}
    let(:profile){create(:profile)}
    let(:valid_profile) do
      post :create, user: attributes_for(:user, profile_attributes: attributes_for(:profile, sex_id: sex.id))
    end
    let(:invalid_profile) do
      post :create, user: attributes_for(:user, profile_attributes: attributes_for(:profile))
    end


    it 'creates a new user when valid attributes passed' do
      expect{valid_profile}.to change(User, :count).by 1
    end

    it 'redirects to root with error flash when invalid attributes are passed' do
      invalid_profile
      expect(response).to redirect_to(root_url)
      expect(flash[:error]).to_not be_nil
    end
  end

  describe 'POST #search' do
    let(:profile){create(:profile) }

    context 'authorized' do
      before do
        request.cookies["auth_token"] = profile.user.auth_token
      end

      it 'returns sets the @users variable to a list of search results - first name' do
        post :search, id: profile.user.id, search: "Foo"
        expect(assigns(:users)).to include(profile.user)
      end

      it 'returns sets the @users variable to a list of search results - last name' do
        post :search, id: profile.user.id, search: "Bar"
        expect(assigns(:users)).to include(profile.user)
      end

      it 'returns sets the @users variable to a list of search results - full name' do
        post :search, id: profile.user.id, search: "Foo Bar"
        expect(assigns(:users)).to include(profile.user)
      end

      it 'returns no results for names not in database' do
        post :search, id: profile.user.id, search: "Eagle Eye"
        expect(assigns(:users)).to_not include(profile.user)
      end

      it 'returns all users if no argument is passed' do
        post :search, id: profile.user.id, search: ""
        expect(assigns(:users)).to include(profile.user)
      end
    end

    context 'not-authorized' do
      it 'redirects to root when not authorized' do
        post :search, id: profile.user.id, search: "Foo Bar"
        expect(response).to redirect_to root_url
      end
    end
   end
  end

