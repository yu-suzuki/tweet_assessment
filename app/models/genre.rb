class Genre < ApplicationRecord
  has_many :tweets

  def tweet_count
    Tweet.where(:genre_id => self.id).count
  end

  def tweet_count_remain
    Tweet.where('genre_id = ? and evaluation_count < ?', self.id, 1).count
  end
end
