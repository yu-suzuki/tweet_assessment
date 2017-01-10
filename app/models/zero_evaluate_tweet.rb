class ZeroEvaluateTweet < ApplicationRecord

  def add_tweet
    if ZeroEvaluateTweet.all.count < 5000
      tweets = Tweets.where(:evaluation_count => 0).limit(5000).pluck(:id)
      tweets.each do |t|
        ZeroEvaluateTweet.create(:tweet_id => t)
      end
    end
  end
end
