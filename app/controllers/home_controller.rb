class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    TaskQueue.where("created_at <= ?", Time.now-30.minutes).delete_all
    @doing_count = TaskQueue.distinct.count(:user_id)
    if current_user.team == 0 && current_user.id % 6 != 0
      current_user.team = current_user.id % 6
      current_user.save
    end
    @to_red_cards = RedCard.where(:to_user_id => current_user.id).order(:updated_at => :desc)

    if current_user.locked
      flash[:success] = "このアカウントはロックされています"
    end
  end


  def practice
    if current_user.practice == false
      current_user.practice = true
    end
    current_user.save
  end
end
