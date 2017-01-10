class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check!

  def index
    @users = User.order(:username).includes(:comment)
    @groups = User.all.group(:team).order('count_all desc').count
    @groups_oneday = User.where('last_sign_in_at > ?', 1.day.ago).group(:team).order('count_all desc').count

  end

  def show
    @user = User.includes(:comment).includes(:enquete).find(params[:id])
    @comment = @user.comment
    unless @comment
      @comment = Comment.new
    end
    @evaluations = Evaluation.where(:user_id => params[:id])
                       .order(:created_at => :desc).page(params[:page]).includes(:tweet).includes(:point)
    @stars = Point.where(:user_id => params[:id])
    @max_stars = Tweet.all.where(:id => Evaluation.where(:user_id => params[:id]).pluck(:tweet_id), :evaluation_count => 5)
    @from_red_cards = RedCard.includes(:to_user).where(:from_user_id => @user.id).order(:updated_at => :desc)
    @to_red_cards = RedCard.includes(:from_user).where(:to_user_id => @user.id).order(:updated_at => :desc)


  end

  private
  def admin_check!
    unless current_user.admin
      redirect_to root_path
    end
  end
end
