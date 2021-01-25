class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: [:show, :destroy]
  def index
    @watchlists = Watchlist.all
    render json: @watchlists
  end

  def create
    @watchlist = Watchlist.create(watchlist_params)
    if @watchlist.errors.any?
      render json: @watchlist.errors, status: :unprocessable_entity
    else
      render json: @watchlist, status: 201
    end
  end

  def show
    render json: @watchlist
  end

  def show_by_user 
    # @userwatchlist = Watchlist.all.foreach(user )
    # Watchlist.find(params[:id])
  end
  
  def destroy
    @watchlist.delete
    render json: 204
  end
  

  private
  def watchlist_params
    params.permit(:user_id, :movie_id, :title)
  end

  def set_watchlist
    begin
      @watchlist = Watchlist.find(params[:id])
    rescue
      render json: {error: "Joke not found"}, status: 404
    end
  end
  
end
