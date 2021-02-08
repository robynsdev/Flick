require 'rails_helper'

RSpec.describe "Watchlists", type: :request do
  describe 'GET watchlists#index' do
    before(:example) do
      @first_watchlist = FactoryBot.create(:watchlist)
      @last_watchlist = FactoryBot.create(:watchlist)
      get watchlists_path
      @json_response = JSON.parse(response.body)
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end   
    it 'JSON response contains the correct number of entries' do
      expect(@json_response.count).to eq(2)
    end    
    it 'JSON response body contains expected attributes' do
      expect(@json_response[0]).to include({
        'id' => @first_watchlist.id,
        'user_id' => @first_watchlist.user_id,
        'movie_id' => @first_watchlist.movie_id,
        'title' => @first_watchlist.title,
      }) 
    end
  end

  describe "POST watchlists#create" do
    before(:example) do
      @watchlist_params = FactoryBot.attributes_for(:watchlist)
      post watchlists_path, params: @watchlist_params, headers: authenticated_header
    end
    it 'returns http created' do
      expect(response).to have_http_status(:created)
    end
    it 'saves the User to the database' do
      expect(Watchlist.last.title).to eq(@watchlist_params[:title])
    end
  end

  describe "GET watchlists#show_list_by_username" do
    before(:example) do
      @user_params = FactoryBot.attributes_for(:user_with_watchlists)
      get "/api/watchlists/#{@user_params[:username]}", headers: authenticated_header
      @json_response = JSON.parse(response.body)
    end
    it 'JSON response contains the correct number of entries' do
      expect(@json_response.count).to eq(5)
    end    
  end

  describe "DELETE watchlists#destroy" do
    context 'when the task is valid' do
      before(:example) do
        @watchlist_params = FactoryBot.create(:watchlist)
        delete watchlists_path(@watchlist_params.id), headers: authenticate_user(@watchlist_params.id)
      end
      it 'returns http 204' do
        expect(response).to have_http_status(204)
      end
    end
    context 'when the task is invalid' do
      before(:example) do
        @watchlist_params = FactoryBot.create(:watchlist)
        delete watchlists_path(@watchlist_params.id), headers: authenticated_header
      end
      it 'returns http 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
