class UsersController < ApplicationController
  before_action :set_user, only: [:update, :delete]


  def create
    @user = User.create(user_params)
    if @user.save
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json: {username: @user.username, jwt: auth_token.token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json: {username: @user.username, jwt: auth_token.token}, status: 200
    else
      render json: {error: "Incorrect email or password"}, status: 404
    end
  end

  def update
    @user.update(user_params)
    if @user.errors.any? 
      render json: @user.errors, status: :unprocessable_entity
    else  
      render json: @user, status: 201
    end 
  end

  def delete
    @user.delete
    render json: 204
  end

  private
  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    begin
      @user = User.find(current_user.id.to_i)
    rescue
      render json: {Error: "User not found"}, status: 404
    end
  end

end
