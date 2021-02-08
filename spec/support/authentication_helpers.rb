module AuthenticationHelpers
  def authenticated_header
    user = FactoryBot.create(:user)
    authenticate_user(user.id)
  end

  def authenticate_user(id)
    token = Knock::AuthToken.new(payload: {sub: id}).token
    { 'Authorization': "Bearer #{token}" }
  end

  # def auth_user_from_spec(user)
  #   token = Knock::AuthToken.new(payload: {sub: user[:username]}).token
  #   { 'Authorization': "Bearer #{token}" }
  # end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end