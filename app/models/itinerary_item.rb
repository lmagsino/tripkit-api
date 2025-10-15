class ItineraryItem < ApplicationRecord
  # Associations
  belongs_to :trip
  belongs_to :created_by_user, class_name: 'User'

  # Validations
  validates :title, presence: true
  validates :date, presence: true
  validates :category, presence: true, 
            inclusion: { in: %w[activity meal transport accommodation other] }

  # Scopes
  scope :ordered, -> { order(date: :asc, time: :asc) }
  scope :by_date, ->(date) { where(date: date) }
end