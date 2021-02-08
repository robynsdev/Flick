require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  describe "POST friendships#create" do
    context 'when the task is valid' do
      before(:example) do
        @friendship_params = FactoryBot.create(:friend)
        @user_params = FactoryBot.create(:user)
        post sign_up_path, params: {:friend_id=>"#{@friendship_params.id}", :user_id=>"#{@user_params.id}"}, headers: authenticated_header
      end
      it 'returns http created' do
        p @friendship_params
        expect(response).to have_http_status(:created)
      end
      it 'saves the Friendship to the database' do
        expect(Friendship.last.user_id).to eq(@friendship_params[:user_id])
      end
    end
  end
end
