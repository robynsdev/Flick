require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST users#create" do
    context 'when the user is valid' do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user)
        post sign_up_path, params: @user_params 
      end
      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end
      it 'saves the User to the database' do
        expect(User.last.username).to eq(@user_params[:username])
      end
    end
    context 'when the user is invalid' do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user, :invalid)
        post sign_up_path, params: @user_params 
      end
      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end      
    end
  end

  describe "POST users#sign_in" do
    context 'when the user is valid' do
      before(:example) do
        @user_params = User.create(
          username: "dog",
          email: "dog@test.com",
          password: "password",
          password_confirmation: "password"
        )
        post sign_in_path, params: {:email=>
        "dog@test.com", :password=>"password"} 
      end
      it 'returns http created' do
        expect(response).to have_http_status(200)
      end
      it 'returns the username' do
        expect(JSON.parse(response.body)['username']).to eq(@user_params[:username])
      end
    end
    context 'when the user is invalid' do
      before(:example) do
        @user_params = User.create(
          username: "dog",
          email: "dog@test.com",
          password: "password",
          password_confirmation: "password"
        )
        post sign_in_path, params: {:email=>
        "dog@test.com", :password=>""} 
      end
      it 'returns http 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET users#profile" do
    context 'when the user is valid' do
      before(:example) do
        @user_params = User.create(
          username: "dog",
          email: "dog@test.com",
          password: "password",
          password_confirmation: "password"
        )
        get profile_path, headers: authenticate_user(@user_params.id)
      end
      it 'returns the username' do
        expect(JSON.parse(response.body)['username']).to eq(@user_params[:username])
      end
      it 'returns the email' do
        expect(JSON.parse(response.body)['email']).to eq(@user_params[:email])
      end
    end
  end

  describe "PUT users#update" do
    context 'when the user is valid' do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user)
        put update_path, params: @user_params, headers: authenticated_header
      end
      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end
      it 'saves the username to the database' do
        expect(User.last.username).to eq(@user_params[:username])
      end
      it 'saves the email to the database' do
        expect(User.last.email).to eq(@user_params[:email])
      end
    end
    context 'when the user is invalid' do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user, :invalid)
        put update_path, params: @user_params, headers: authenticated_header
      end
      it 'returns unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE users#delete" do
    before(:example) do
      @user_params = FactoryBot.attributes_for(:user)
      delete delete_path, params: @user_params, headers: authenticated_header 
    end
    it 'returns http created' do
      expect(response).to have_http_status(204)
    end
  end
end
