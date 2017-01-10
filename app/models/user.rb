class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :evaluations
  has_many :points
  has_one :comment
  has_one :enquete
  has_many :task_queues
  has_many :red_cards, :foreign_key => :to_user_id
  has_many :point_rates


  def weighted_score
    score = 0.0
    points.each do |p|
      score += p.rate
    end

    score.round(1)
  end

  def point
    (Evaluation.where(:user_id => self.id).count * 0.5 + Point.where(:user_id => self.id).count * 0.5 + (RedCard.where(:from_user_id => self.id).count * 5)).round(1)
  end

  def rate
    point_rates = PointRate.where(:user_id => self.id).order(:created_at => :desc)
    if point_rates.first.nil?
      1.0
    else
      point_rates.first.rating.round(2)
    end
  end

  def star
    star_count = (((self.rate - 1.to_f).round(2) / 2) * 10).to_i
  end

  def red_card
    red = 0
    red_cards = RedCard.where(:to_user_id => self.id).order(:created_at => :desc).limit(5)
    red_cards.each do |r|
      if r.evaluation < 0
        red += 1
      end
    end
    red
  end

end
