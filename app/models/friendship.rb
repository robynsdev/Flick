class Friendship < ApplicationRecord
  belongs_to :requester
  belongs_to :addressee
end
