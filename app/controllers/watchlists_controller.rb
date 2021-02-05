class WatchlistsController < ApplicationController
  before_action :authenticate_user, except: [:index]
  before_action :find_by_username, only: [:show_list_by_username]
  before_action :find_movie, only: [:destroy]
  before_action :check_ownership, only: [:destroy]

  def index
    @watchlists = Watchlist.all
    render json: @watchlists
  end

  def create
    @watchlist = current_user.watchlists.create(watchlist_params)
    if @watchlist.errors.any?
      render json: @watchlist.errors, status: :unprocessable_entity
    else
      render json: @watchlist, status: 201
    end
  end

  def show_list_by_username
    @userwatchlist = Watchlist.where(user_id: @id)
    if @userwatchlist.empty?
      render json: {Error: "No favourites found"}, status: 404
    else
      render json: @userwatchlist
    end
  end
  
  def destroy
    @watchlist.destroy
    render status: 204
  end
  

  private
  def watchlist_params
    params.permit(:user_id, :movie_id, :title)
  end

  def find_movie
    begin
      @watchlist = Watchlist.find(params[:id])
    rescue
      render json: {Error: "Movie not found"}, status: 404
    end
  end

  def find_by_username
    @id = User.find_by_username(params[:username]).id
  end

  def check_ownership
    if current_user.id != @watchlist.user.id
      render json: {Error: "You don't have permission to do that."}, status: 401
    end
  end
  
end
