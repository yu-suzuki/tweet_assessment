class Point < ApplicationRecord
  belongs_to :user, :counter_cache => true
  belongs_to :tweet
  belongs_to :evaluation
end
