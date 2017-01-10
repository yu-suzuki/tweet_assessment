class GenreController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check!

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:genre_id])
    if params[:category]
      case params[:category]
        when "pn"
          @entries = Tweet.where(:genre_id => params[:genre_id], :pn_flag => 1).order(:evaluation_count => :desc).page(params[:page])
        when "p"
          @entries = Tweet.where(:genre_id => params[:genre_id], :p_flag => 1).order(:evaluation_count => :desc).page(params[:page])
        when "n"
          @entries = Tweet.where(:genre_id => params[:genre_id], :n_flag => 1).order(:evaluation_count => :desc).page(params[:page])
        when "ne"
          @entries = Tweet.where(:genre_id => params[:genre_id], :ne_flag => 1).order(:evaluation_count => :desc).page(params[:page])
        when "na"
          @entries = Tweet.where(:genre_id => params[:genre_id], :na_flag => 1).order(:evaluation_count => :desc).page(params[:page])
      end


    else
      @entries = Tweet.where(:genre_id => params[:genre_id]).order(:evaluation_count => :desc).page(params[:page])
    end
  end

  private
  def admin_check!
    unless current_user.admin
      redirect_to root_path
    end
  end
end
