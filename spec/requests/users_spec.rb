require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET users#create" do
    context 'when the task is valid' do
      before(:example) do
        @user_params = FactoryBot.attributes_for(:user)
        p @user_params[:username]
        post sign_up_path, params: { user: @user_params }
      end
      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end
      it 'saves the User to the database' do
        expect(User.last.username).to eq(@user_params[:username])
      end
    end
  end
end
