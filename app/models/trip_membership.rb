class TripMembership < ApplicationRecord
  # Associations
  belongs_to :trip
  belongs_to :user

  # Validations
  validates :role, presence: true, inclusion: { in: %w[creator member] }
  validates :joined_at, presence: true
  validates :user_id, uniqueness: { scope: :trip_id, message: "is already a member of this trip" }

  # Callbacks
  before_validation :set_joined_at, on: :create

  private

  def set_joined_at
    self.joined_at ||= Time.current
  end
end