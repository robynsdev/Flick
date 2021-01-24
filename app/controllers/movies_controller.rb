class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :destroy]
  def index
    @movies = Movie.all
    render json: @movies
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie.errors.any?
      render json: @movie.errors, status: :unprocessable_entity
    else
      render json: @movie, status: 201
    end
  end

  def show
    render json: @movie
  end
  
  def destroy
    @movie.delete
    render json: 204
  end
  

  private
  def movie_params
    params.permit(:title, :release_date, :description, :genre, :runtime)
  end

  def set_movie
    begin
      @movie = Movie.find(params[:id])
    rescue
      render json: {error: "Joke not found"}, status: 404
    end
  end

end
