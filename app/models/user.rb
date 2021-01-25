class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :watchlists
  has_many :requesters, class_name: 'Friendships', foreign_key: :requester_id
  has_many :addressees, class_name: 'Friendships', foreign_key: :addressee_id
end
