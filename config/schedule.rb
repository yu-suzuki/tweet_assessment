# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :output, "log/cron_log.log"
# ジョブ実行環境を指定
# 事故防止の為RAILS_ENVの指定が無い場合にはdevelopmentを使用する
rails_env = ENV['RAILS_ENV'] || :development

every 10.minutes do
  rake "maintainance:add_tweets"
end
