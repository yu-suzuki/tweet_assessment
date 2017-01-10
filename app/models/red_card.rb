class RedCard < ApplicationRecord
  validates :comment, length: { maximum: 200}
  validates :comment, length: { minimum: 1}
  validates_presence_of :comment, :message => "コメントを入れてください",:on =>[:save, :create, :update]
  validates_presence_of :evaluation, :message => "評価を入れてください",:on =>[:save, :create, :update]

  belongs_to :from_user, :class_name => 'User'
  belongs_to :to_user, :class_name => 'User'
end
