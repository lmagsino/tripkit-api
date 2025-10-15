class ExpenseSplit < ApplicationRecord
  # Associations
  belongs_to :expense
  belongs_to :user

  # Validations
  validates :share_amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, uniqueness: { scope: :expense_id, message: "already has a split for this expense" }
end