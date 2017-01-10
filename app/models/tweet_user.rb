class TweetUser < ApplicationRecord
  has_many :tweets
  validates :user_id, :uniqueness => true
end
