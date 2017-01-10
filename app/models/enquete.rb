class Enquete < ApplicationRecord
  validates :sex, presence: true
  validates :age, presence: true
  validates :place, presence: true
  validates :job, presence: true
  validates :machine, presence: true
  validates :user_id, presence: true
  validates :motivation, presence: true

  belongs_to :user
end
