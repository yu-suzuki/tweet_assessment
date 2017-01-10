namespace :maintainance do
  desc "Tweetsの中を更新"
  task :add_tweets => :environment do
    if ZeroEvaluateTweet.all.count < 1000
      tweets = Tweet.where(:evaluation_count => 0).limit(5000)
      tweets.each do |t|
        ZeroEvaluateTweet.create(:tweet_id => t.id)
      end
    end
  end
end
