class RedCardController < ApplicationController
  before_action :authenticate_user!

  def new
    @red_card = RedCard.new
    user_ids = User.where('(team > ?) and (evaluations_count > ?)', 2, 200).order(:).pluck(:id)
    done_ids = RedCard.where(:from_user_id => current_user.id).pluck(:to_user_id)
    done_ids << current_user.id
    candidate_ids = user_ids - done_ids
    p candidate_ids, user_ids, done_ids
    if candidate_ids.empty?
      session['no_red_card'] = true
      redirect_to new_evaluation_path
    else
      session['no_red_card'] = true
      @target_user = User.includes(:evaluations => {:tweet => :genre}).find(candidate_ids.sample(1)[0])
    end

  end

  def create
    redcard = RedCard.new(red_card_params)
    p redcard
    if redcard.save
      to_user_id = red_card_params[:to_user_id].to_i
      target_user = User.find(to_user_id)
      current_point_rate = target_user.point_rates.order(:created_at => :desc).first
      current_rate = 1
      if !current_point_rate.nil?
        current_rate = current_point_rate.rating
      end
      p redcard
      if redcard.evaluation > 0
        new_rate = current_rate + 0.2
        if new_rate > 2
          new_rate = 2
        end
      elsif redcard.evaluation < 0
        new_rate = current_rate - 0.2
        if new_rate < 1
          new_rate = 1
        end
      else
        new_rate = current_rate
      end
      p new_rate, current_rate
      point_rate = PointRate.new(:user_id => to_user_id, :rating => new_rate)
      point_rate.save

      user = User.find(to_user_id)
      if (user.team == 3 || user.team == 5)
        red_cards = RedCard.where(:to_user_id => to_user_id).order(:created_at).limit(5)
        negative_count = 0
        red_cards.each do |r|
          if r.evaluation < 0
            negative_count += 1
          end
        end
        if negative_count > 3
          target_user.locked = true
          target_user.save
        end
      end

    else
      flash[:notice]="評価がされていないか，コメントが書かれていなかった，もしくはサーバの不具合により登録できませんでした"

    end
    redirect_to new_evaluation_path
  end

  private
  def red_card_params
    params.require(:red_card).permit(:from_user_id, :to_user_id, :evaluation, :comment)
  end
end
