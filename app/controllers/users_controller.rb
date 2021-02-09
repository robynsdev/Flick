class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create, :sign_in]
  before_action :set_user, only: [:profile, :update, :delete]

  # User is created using user params. Returns the username and jwt token when successful. Returns an error if any params are not sent.
  def create
    @user = User.create(user_params)
    if @user.save
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json: {username: @user.username, jwt: auth_token.token}, status: :created
    else
        render json: @user.errors, status: :unprocessable_entity
    end 
  end 

  # User signs in using email and password. Returns username and jwt token when successful. Returns an error if email or password is incorrect.
  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json: {username: @user.username, jwt: auth_token.token}, status: 200
    else
      render json: {error: "Incorrect email or password"}, status: 404
    end
  end

  # Returns user params of current user from jwt. Returns username and email.
  def profile
    render json: { username: @user.username, email: @user.email }
  end

  # Updates the params of a user. All fields must be filled. Returns user params when successful. Returns error if unsuccessful. 
  def update
    @user.update(user_params)
    if @user.errors.any? 
      render json: @user.errors, status: :unprocessable_entity
    else  
      render json: @user, status: 201
    end 
  end

  # Deletes user by user id from jwt. 
  def delete
    @user.destroy
    render status: 204
  end

  private
  def user_params
    params.permit(:user, :username, :email, :password, :password_confirmation)
  end

  def set_user
      @user = User.find(current_user.id.to_i)
  end

end
