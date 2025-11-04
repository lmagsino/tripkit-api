class ExpenseSplit < ApplicationRecord
  # Associations
  belongs_to :expense
  belongs_to :user, optional: true

  # Validations
  validates :share_amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, uniqueness: { scope: :expense_id, message: "already has a split for this expense" }, allow_nil: true
  validate :must_have_user_or_guest_name

  # Methods
  def display_name
    user&.name || guest_name || "Unknown"
  end

  def is_guest?
    user_id.nil?
  end

  private

  def must_have_user_or_guest_name
    if user_id.nil? && guest_name.blank?
      errors.add(:base, "Must have either a user or guest name")
    end
  end
end