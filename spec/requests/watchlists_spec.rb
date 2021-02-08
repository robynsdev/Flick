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

  describe "GET watchlists#create" do
    before(:example) do
      @watchlist_params = FactoryBot.attributes_for(:watchlist)
      post watchlists_path, params: { user: @watchlist_params }
    end
    it 'returns http created' do
      expect(response).to have_http_status(:created)
    end
    it 'saves the User to the database' do
      expect(Watchlist.last.title).to eq(@watchlist_params[:title])
    end
  end
end
