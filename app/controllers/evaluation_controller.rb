class EvaluationController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check!, :only => [:list]

  def index
  end

  def list
    @evaluations = Evaluation.all.order(:created_at => :desc).includes(:tweet).includes(:user).page(params[:page])
  end

  def new
    if ((!session['no_red_card'] || session['no_red_card'] == false) && current_user.team !=0 && current_user.team != 1 && current_user.evaluations.count > 100 &&
        current_user.evaluations.count % 50 == 0)
      redirect_to red_card_new_path
    end
    session['no_red_card'] = false

    if current_user.locked
      flash[:danger] = 'このアカウントはロックされています'
      redirect_to root_path
    end

    if (current_user.team == 3 || current_user.team == 4 || current_user.team == 5)
      red_card = current_user.red_cards.where(:read_flag => false).order(:created_at)
      if red_card.count > 0
        r = red_card.first
        flash[:danger] = "コメント:"+r.comment
        r.read_flag = true
        r.save
      end
    end

    session['start_at'] = Time.now

    r = Random.new
    genre_id = r.rand(0..Genre.count-1)
    if (current_user.team == 2 ||current_user.team == 3 || current_user.team == 4 || current_user.team == 5)
      @point = User.find(current_user.id).point
      if session['point'] && (@point - session['point']) > 0.5
        flash.now[:success] = (@point - session['point']).round(1).to_s+'ポイント増えました'
      end
      session['point'] = @point
    end

    #done = Evaluation.where(:user_id => current_user.id).pluck(:tweet_id)
    #queue = TaskQueue.all.pluck(:tweet_id)

    #candidate = Tweet.where('evaluation_count < ? and evaluation_count > ?', 5, 0)
    #                .order(:evaluation_count => :desc).limit(100).pluck(:id)

    #candidate = Tweet.where('evaluation_count < 5').where.not(:id => done, :id => queue).order(:evaluation_count).limit(10)

    genre_candidate = []
    Genre.all.each do |g|
      genre_candidate << g.id if g.tweet_count_remain > 0
    end
    genre_id = genre_candidate.sample(1)
    p genre_id
    candidate = Tweet.find_by_sql(['select id from (select evaluation_count,id from tweets t where genre_id=? and evaluation_count < 5 and not exists (select 1 from evaluations e where  e.tweet_id = t.id and e.user_id = ?) and not exists (select 1 from task_queues q where q.tweet_id = t.id) order by evaluation_count desc) where ROWNUM < 10 order by evaluation_count desc', genre_id, current_user.id]);

    # candidate0 = Tweet.where(:evaluation_count => 4).limit(100).pluck(:id)
    # candidate1 = candidate0 - @done.pluck(:tweet_id) - queue
    # if candidate1.empty?
    #   candidate2 = candidate - @done.pluck(:tweet_id)
    #   #p candidate2
    #   candidate3 = candidate2 - queue
    #   #p candidate3
    #   if candidate3.empty?
    #     candidate2 = Tweet.where(:evaluation_count => 0).limit(100).pluck(:id)
    #     candidate3 = candidate2 - queue
    #   end
    # else
    #   candidate3 = candidate1
    # end

    #p candidate3
    if candidate.empty?
      flash[:danger] = 'もう作業がありません'
      redirect_to root_path
    else
      @tweet = Tweet.includes(:genre).find(candidate.sample(1)[0].id)
      @evaluation = Evaluation.new
      TaskQueue.create(:tweet_id => @tweet.id, :user_id => current_user.id)
    end
  end

  def create
    tweet_id = evaluation_params['tweet_id'].to_i
    ZeroEvaluateTweet.where(:tweet_id => tweet_id).delete_all
    if (Evaluation.where(:user_id => current_user.id, :tweet_id => tweet_id).count == 0)
      evaluation = Evaluation.new(evaluation_params)
      evaluation.start_at = session['start_at']
      evaluation.end_at = Time.now
      evaluation.elapsed = Time.now.to_i - Time.parse(session['start_at']).to_i
      p "******"
      if (evaluation.positive && evaluation.negative && !evaluation.neutral && !evaluation.na) ||
          (evaluation.positive && !evaluation.negative && !evaluation.neutral && !evaluation.na) ||
          (!evaluation.positive && evaluation.negative && !evaluation.neutral && !evaluation.na) ||
          (!evaluation.positive && !evaluation.negative && evaluation.neutral && !evaluation.na)||
          (!evaluation.positive && !evaluation.negative && !evaluation.neutral && evaluation.na)
          evaluation.save
          set_evaluations_count tweet_id

          session['start_at'] = nil
          tweet = Tweet.includes(:genre).includes(:tweet_user).find(tweet_id)
          evaluation_count = Evaluation.where(:tweet_id => tweet_id).count
          tweet.evaluation_count = evaluation_count
          tweet.save
          TaskQueue.where("tweet_id = ? and user_id = ?", evaluation_params['tweet_id'].to_i, current_user.id).delete_all
          TaskQueue.where("created_at <= ?", Time.now-30.minutes).delete_all

          if Evaluation.where(:tweet_id => tweet_id).count >= 5
            get_point tweet_id
          end

          user = User.find(current_user.id)
          user.evaluations_count = Evaluation.where(:user_id => current_user.id).count
          user.save

          redirect_to :action => :new
      else
        flash[:success] = '選択は誤りです．良いと悪いの両方，良い，悪い，判断できない，関係がない，のいずれかを選択してください．'
        redirect_to new_evaluation_path
      end
      p evaluation.positive
      p "******"

    end

  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:user_id, :tweet_id, :positive, :negative, :neutral, :na)
  end

  def get_point tweet_id
    tweet = Tweet.find(tweet_id)
    if tweet.pn_flag
      wins = Evaluation.where(:tweet_id => tweet_id, :positive => true, :negative => true)
      wins.each do |w|
        ratings = PointRate.where(:user_id => w.user_id).order(:created_at)
        if (ratings.count > 0)
          rating = ratings.first.rating
        else
          rating = 1
        end
        if Point.where(:tweet_id => tweet_id, :user_id => w.user_id).count == 0
          Point.create(:tweet_id => tweet_id, :user_id => w.user_id, :evaluation_id => w.id, :rate => rating)
        end
      end
    end
    if tweet.p_flag
      wins = Evaluation.where(:tweet_id => tweet_id, :positive => true, :negative => false)
      wins.each do |w|
        ratings = PointRate.where(:user_id => w.user_id).order(:created_at)
        if (ratings.count > 0)
          rating = ratings.first.rating
        else
          rating = 1
        end
        if Point.where(:tweet_id => tweet_id, :user_id => w.user_id).count == 0
          Point.create(:tweet_id => tweet_id, :user_id => w.user_id, :evaluation_id => w.id)
        end
      end
    end
    if tweet.n_flag
      wins = Evaluation.where(:tweet_id => tweet_id, :positive => false, :negative => false)
      wins.each do |w|
        ratings = PointRate.where(:user_id => w.user_id).order(:created_at)
        if (ratings.count > 0)
          rating = ratings.first.rating
        else
          rating = 1
        end
        if Point.where(:tweet_id => tweet_id, :user_id => w.user_id).count == 0
          Point.create(:tweet_id => tweet_id, :user_id => w.user_id, :evaluation_id => w.id)
        end
      end
    end
    if tweet.ne_flag
      wins = Evaluation.where(:tweet_id => tweet_id, :neutral => true)
      wins.each do |w|
        ratings = PointRate.where(:user_id => w.user_id).order(:created_at)
        if (ratings.count > 0)
          rating = ratings.first.rating
        else
          rating = 1
        end
        if Point.where(:tweet_id => tweet_id, :user_id => w.user_id).count == 0
          Point.create(:tweet_id => tweet_id, :user_id => w.user_id, :evaluation_id => w.id)
        end
      end
    end
    if tweet.na_flag
      wins = Evaluation.where(:tweet_id => tweet_id, :na => true)
      wins.each do |w|
        ratings = PointRate.where(:user_id => w.user_id).order(:created_at)
        if (ratings.count > 0)
          rating = ratings.first.rating
        else
          rating = 1
        end
        if Point.where(:tweet_id => tweet_id, :user_id => w.user_id).count == 0
          Point.create(:tweet_id => tweet_id, :user_id => w.user_id, :evaluation_id => w.id)
        end
      end
    end
  end

  def set_evaluations_count tweet_id
    evaluations = Evaluation.where(:tweet_id => tweet_id)
    bins = [0, 0, 0, 0, 0]
    evaluations.each do |e|
      if e.positive && e.negative
        bins[0] += 1
      elsif e.positive && !e.negative
        bins[1] += 1
      elsif !e.positive && e.negative
        bins[2] += 1
      elsif e.neutral
        bins[3] += 1
      elsif e.na
        bins[4] += 1
      end
    end
    max = get_arg_max bins
    tw = Tweet.includes(:genre).includes(:tweet_user).find(tweet_id)
    tw.evaluation_count = evaluations.count
    tw.pn_count = bins[0]
    tw.p_count = bins[1]
    tw.n_count = bins[2]
    tw.ne_count = bins[3]
    tw.na_count = bins[4]
    p max[0]
    if max[0].include?(0)
      tw.pn_flag = true
    else
      tw.pn_flag = false
    end
    if max[0].include?(1)
      tw.p_flag = true
    else
      tw.p_flag = false
    end
    if max[0].include?(2)
      tw.n_flag = true
    else
      tw.n_flag = false
    end
    if max[0].include?(3)
      tw.ne_flag = true
    else
      tw.ne_flag = false
    end
    if max[0].include?(4)
      tw.na_flag = true
    else
      tw.na_flag = false
    end
    tw.save


=begin
    max = get_arg_max bins
    max_value = max[1]
    max_index = max[0]
    if max_value > (evaluations.length / 2)
      case max_index
        when 0
          wins = Evaluation.where(:tweet_id => tweet_id, :positive => true, :negative => true)
        when 1
          wins = Evaluation.where(:tweet_id => tweet_id, :positive => true, :negative => false)
        when 2
          wins = Evaluation.where(:tweet_id => tweet_id, :positive => false, :negative => false)
        when 3
          wins = Evaluation.where(:tweet_id => tweet_id, :neutral => true)
        when 4
          wins = Evaluation.where(:tweet_id => tweet_id, :na => true)
      end
      wins.each do |w|
        Point.find_or_create_by(:tweet_id => tweet_id, :user_id => w.user_id, :evaluation_id => w.id)
      end
    end
=end

  end

  def get_arg_max bins
    max_value = -1
    bins.each do |b|
      max_value = b if max_value < b
    end
    max_array = []
    bins.each_with_index do |v, i|
      max_array << i if v == max_value
    end
    [max_array, max_value]
  end

  def admin_check!
    unless current_user.admin
      redirect_to root_path
    end
  end
end
