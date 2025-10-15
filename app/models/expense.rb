class Expense < ApplicationRecord
  # Associations
  belongs_to :trip
  belongs_to :paid_by_user, class_name: 'User'
  has_many :expense_splits, dependent: :destroy

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true
  validates :category, presence: true
  validates :split_type, presence: true, inclusion: { in: %w[equal custom] }
  validates :expense_date, presence: true

  # Callbacks
  before_validation :set_expense_date, on: :create

  private

  def set_expense_date
    self.expense_date ||= Date.current
  end
end