class User < ApplicationRecord
  has_many :users_movies
  has_many :requesters, class_name: 'Friendships', foreign_key: :requester_id
  has_many :addressees, class_name: 'Friendships', foreign_key: :addressee_id
end
