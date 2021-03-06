class FriendshipsController < ApplicationController
  before_action :authenticate_user
  before_action :find_friend_by_email, only: [:create]
  before_action :find_friend_by_username, only: [:destroy]
  before_action :find_friendship, only: [:create, :destroy]

  # Returns a list of friendships of a user. 
  # User is found by user id from jwt token.
  def show_list_by_user_id
    @id = current_user.id
    @userfriendships = User.find(@id).friends
    if @userfriendships.empty?
      render json: {Error: "No friends found"}, status: 404
    else
      render json: @userfriendships.to_json(:only => [:id, :username])
    end
  end

  # Friendship is created using current_user from jwt and friend's email.
  def create
    # prevent user from adding friends who are already on friends list.
    if @friendship
      render json: { Message: "You're already friends!" }, status: :unprocessable_entity
    else
      @friend = current_user.friendships.create(:friend_id => @friend_id)
      render json: @friend, status: 201
    end
  end
  
  # Destroys a friendship using current_user from jwt and friend's username.
  def destroy
    # prevent user from deleting a friendship which cannot be found.
    if !(@friendship)
      render json: {error: "Friendship not found"}, status: 404
    else
      @friendship.destroy
      render status: 204
    end
  end
  

  private

  # Finds a user id using the username sent in url. Returns an error if not found.
  def find_friend_by_username
    begin
      @friend_id = User.find_by(username: params[:username]).id
    rescue
      render json: {error: "Friend not found"}, status: 404
    end
  end

  # Finds a user id using the email sent in url. Returns an error if not found. 
  def find_friend_by_email
    begin
      @friend_id = User.find_by(email: params[:email]).id
    rescue
      render json: {error: "Friend not found"}, status: 404
    end
  end

  # Find a friendship using two user ids. Returns a true or false which does not trigger an error.
  def find_friendship
    @friendship = current_user.friendships.find_by_user_id_and_friend_id(current_user.id, @friend_id)
  end
end
