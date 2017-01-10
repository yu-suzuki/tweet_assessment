class Evaluation < ApplicationRecord
  validate :at_least_one_option_is_selected

  belongs_to :user
  belongs_to :tweet
  has_many :aspects
  has_one :point

  def at_least_one_option_is_selected
    if !positive && !negative && !neutral && !na
      errors.add(:select_one, "少なくとも一つの選択肢を選択してください")
    end
  end

end
