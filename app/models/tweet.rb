class Tweet < ApplicationRecord
  validates :tweet_id, :uniqueness => true
  has_many :evaluations
  belongs_to :tweet_user
  belongs_to :genre

  has_many :points
  has_many :task_queues
end
