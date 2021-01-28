class FriendshipsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show_list_by_user_id]
  before_action :find_friend_by_email, only: [:create]
  before_action :find_friend, only: [:destroy]
  before_action :check_ownership, only: [:destroy]

  def index
    @friendships = Friendship.all
    render json: @friendships
  end

  # prevent user from adding friends who are already on friends list
  def create
    if Friendship.where(user_id: current_user.id, friend_id: @friend_id).present?
      render json: { Message: "You're already friends!" }, status: :unprocessable_entity
    else
      @friendship = current_user.friendships.create(:friend_id => @friend_id)
      if @friendship.errors.any?
        render json: @friendship.errors, status: :unprocessable_entity
      else
        render json: @friendship, status: 201
      end
    end
  end

  def show_list_by_user_id
    @userfriendships = User.find(params[:id]).friends
    if @userfriendships.empty?
      render json: {Error: "No friends found"}, status: 404
    else
      render json: @userfriendships.to_json(:only => [:id, :username])
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id]).present?
    @friendship.destroy
    render json: 204
  end
  

  private
  def friendship_params
    params.permit(:user_id, :friend_id, :email)
  end

  def find_friend
    begin
      @friendship = Friendship.find(params[:id])
    rescue
      render json: {Error: "Friend not found"}, status: 404
    end
  end

  def find_friend_by_email
    begin
      @friend_id = User.find_by(email: params[:email]).id
    rescue
      render json: {Error: "Friend not found"}, status: 404
    end
  end

  def check_ownership
    if current_user.id != @friendship.user.id
      render json: {Error: "You don't have permission to do that."}, status: 401
    end
  end
  
end
