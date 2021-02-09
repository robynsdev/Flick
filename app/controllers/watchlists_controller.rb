class WatchlistsController < ApplicationController
  before_action :authenticate_user, except: [:index]
  before_action :find_by_username, only: [:show_list_by_username]
  before_action :find_movie, only: [:destroy]
  before_action :check_ownership, only: [:destroy]

  # Returns a list of all watchlists.
  def index
    @watchlists = Watchlist.all
    render json: @watchlists
  end

  # Creates a watchlist using user id from jwt and watchlist params. Returns the watchlist if successful. Returns errors if unsuccessful.
  def create
    @watchlist = current_user.watchlists.create(watchlist_params)
    if @watchlist.errors.any?
      render json: @watchlist.errors, status: :unprocessable_entity
    else
      render json: @watchlist, status: 201
    end
  end

  # Returns a list of watchlists for a user using a username. Returns an error if unsuccessful. 
  def show_list_by_username
    @userwatchlist = Watchlist.where(user_id: @id)
    if @userwatchlist.empty?
      render json: {Error: "No favourites found"}, status: 404
    else
      render json: @userwatchlist
    end
  end
  
  # Destroys a watchlist using an id. Checks if user is owner of the watchlist. If not, returns an error. 
  def destroy
    @watchlist.destroy
    render status: 204
  end
  

  private
  
  def watchlist_params
    params.permit(:user_id, :movie_id, :title)
  end

  # Find a watchlist by watchlist id. 
  def find_movie
      @watchlist = Watchlist.find(params[:id])
  end

  # Find a user by username and return the user id.
  def find_by_username
    @id = User.find_by_username(params[:username]).id
  end

  # Check if user id in jwt does not match user id or owner of watchlist. Returns error if true.
  def check_ownership
    if current_user.id != @watchlist.user.id
      render json: {Error: "You don't have permission to do that."}, status: 401
    end
  end
  
end
