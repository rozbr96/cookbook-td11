class Review < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :grade, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :grade, presence: true
  validates :text, presence: true
end
