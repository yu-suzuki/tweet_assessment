# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'zlib'
require 'json'


def extract_file file, genre

  Zlib::GzipReader.open(file) do |f|
    f.each do |l|
      h = JSON.parse(l)
      if h['entities']['urls'].empty? and h['entities']['user_mentions'].empty? and !h['entities']['media'] and !h['source'].include?('auto') and !h['source'].include?('appspot') and !h['source'].include?('bot') and !h['source'].include?('TweetMag1c') and !h['source'].include?('twirobo') and !h['source'].include?('auctranking') and !h['source'].include?('twisuke') and !h['source'].include?('yahoo') and !h['source'].include?('facebook') and !h['source'].include?('market.android.com') and !h['source'].include?('twitterfeed') and !h['source'].include?('ifttt') and h['in_reply_to_screen_name'].nil? and h['in_reply_to_status_id'].nil? and h['in_reply_to_user_id'].nil? and h['lang'] == 'ja'
        tweet_user_id = h['user']['id']
        tweet_user = h['user']['name']
        tweet_user_screen_name = h['user']['screen_name']
        TweetUser.find_or_create_by(:user_id => tweet_user_id, :user_name => tweet_user, :screen_name => tweet_user_screen_name)
      end
    end
  end

  Zlib::GzipReader.open(file) do |f|
    f.each do |l|
      h = JSON.parse(l)
      if h['entities']['urls'].empty? and h['entities']['user_mentions'].empty? and !h['entities']['media'] and !h['source'].include?('auto') and !h['source'].include?('appspot') and !h['source'].include?('bot') and !h['source'].include?('TweetMag1c') and !h['source'].include?('twirobo') and !h['source'].include?('auctranking') and !h['source'].include?('twisuke') and !h['source'].include?('yahoo') and !h['source'].include?('facebook') and !h['source'].include?('market.android.com') and !h['source'].include?('twitterfeed') and !h['source'].include?('ifttt') and h['in_reply_to_screen_name'].nil? and h['in_reply_to_status_id'].nil? and h['in_reply_to_user_id'].nil? and h['lang'] == 'ja'
        tu = TweetUser.find_by(:user_id => h['user']['id'])
        tid = h['id']
        if(Tweet.where(:tweet => h['text']).count == 0 and Tweet.where(:tweet_id => tid).count == 0)
          Tweet.find_or_create_by(:tweet_id => tid, :tweet => h['text'], :tweet_date => h['created_at'],
                               :genre_id => genre.id, :source => h['source'], :tweet_user_id => tu.id)
        end
      end
    end
  end
end

dirs = ['xperia', 'aquos1', 'aquos2', 'cocorobo', 'iphone6', 'panasonic', 'print_service', 'roomba', 'sharp']
dirs.each do |dir|
  genre = Genre.find_or_create_by(:genre_name => dir)
  p dir
  Dir.glob('db/data/SHARP20160916/'+dir+'/201501*.gz').each do |d|
    extract_file d, genre
  end
end

#CSV.foreach('db/data/tweets2.csv') do |r|
#  p r[4]
#  tweet_user_id = r[3]
#  tweet_user = r[2]
#  TweetUser.find_or_create_by(:user_id => tweet_user_id) do |u|
#    u.user_name = tweet_user
#  end
#  t = TweetUser.find_by(:user_id => tweet_user_id)
#  tid = r[1]
#  Tweet.find_or_create_by(:tweet_id => tid) do |t|
#    t.tweet = r[5]
#    t.tweet_date = r[0]
#    t.genre_id = r[4].to_i
#  end
#end