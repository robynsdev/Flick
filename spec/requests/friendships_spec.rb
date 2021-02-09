require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  context 'when the user is valid' do
    describe "POST friendships#create" do
      context 'when the task is valid' do
        before(:example) do
          @user1 = FactoryBot.create(:user)        
          @user2 = FactoryBot.create(:user)        
          post friendships_path, params: {:email=>@user2.email}, headers: authenticate_user(@user1.id)
        end
        it 'returns http created' do
          p @user1
          p @user2.email
          expect(response).to have_http_status(:created)
        end
        it 'saves the Friendship to the database' do
          expect(Friendship.last.user_id).to eq(@user1.id)
        end
      end
    end
  end
  context 'when you are already friends' do
    describe "POST friendships#create" do
      context 'when the task is valid' do
        before(:example) do
          @user1 = FactoryBot.create(:user_with_friendships)        
          @user2 = @user1.friends.last     
          post friendships_path, params: {:email=>@user2.email}, headers: authenticate_user(@user1.id)
        end
        it 'returns http unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
  context 'when friend not found' do
    describe "POST friendships#create" do
      context 'when the task is valid' do
        before(:example) do
          @user1 = FactoryBot.create(:user_with_friendships)        
          post friendships_path, params: {:email=>"test@email.com"}, headers: authenticate_user(@user1.id)
        end
        it 'returns http unprocessable_entity' do
          expect(response).to have_http_status(404)
        end
      end
    end
  end

  describe "GET friendships#show_list_by_user_id" do
    context 'when the user is valid' do
      before(:example) do
        @user = FactoryBot.create(:user_with_friendships)        
        get friendships_path, headers: authenticate_user(@user.id)
      end
      it 'JSON response contains the correct number of entries' do
        expect(JSON.parse(response.body).count).to eq(5)
      end    
      it 'returns the username' do
        expect(JSON.parse(response.body).last["username"]).to eq(@user.friends.last.username)
      end
    end
    context 'when the user has no friends' do
      before(:example) do
        @user = FactoryBot.create(:user)        
        get friendships_path, headers: authenticate_user(@user.id)
      end
      it 'returns http 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE friendships#destroy" do
    context 'when the user is creator of friendship' do
      before(:example) do
        @user = FactoryBot.create(:user_with_friendships)
        delete "/api/friendships/#{@user.friends.last.username}", headers: authenticate_user(@user.id)
      end
      it 'returns http 204' do
        expect(response).to have_http_status(204)
      end
    end
    context 'when friend not found' do
      before(:example) do
        delete "/api/friendships/friendname", headers: authenticated_header
      end
      it 'returns http 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns error: Friend not found' do
        expect(JSON.parse(response.body)['error']).to eq("Friend not found")
      end
    end
    context 'when friendship not found' do
      before(:example) do
        @user1 = FactoryBot.create(:user_with_friendships)        
        @user2 = FactoryBot.create(:user)        
        delete "/api/friendships/#{@user1.friends.last.username}", headers: authenticate_user(@user2.id)
      end
      it 'returns http 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns error: Friendship not found' do
        expect(JSON.parse(response.body)['error']).to eq("Friendship not found")
      end
    end
  end
end
