class Watchlist < ApplicationRecord
  belongs_to :user
  
  def self.find_by_user(input)
    user = User.find_by(name: input)
    return self.where(user: user)
  end

  def transform_watchist
    return {  
      user: self.user.username,
      id: self.movie_id,
      title: self.title,
      created: self.created_at
    }
  end
end
