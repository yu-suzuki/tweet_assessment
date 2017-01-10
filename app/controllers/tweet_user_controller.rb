class TweetUserController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check!

  def index
    @users = TweetUser.all.order(:screen_name).page(params[:page])
  end

  def show
    @user = TweetUser.find(params[:id])
    @entries = @user.tweets.includes(:genre).order(:tweet_date).page(params[:page])
  end

  private
  def admin_check!
    unless current_user.admin
      redirect_to root_path
    end
  end
end
