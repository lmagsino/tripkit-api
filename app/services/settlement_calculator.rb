class SettlementCalculator
  def initialize(trip, currency = nil)
    @trip = trip
    @currency = currency || trip.active_currency
  end

  def calculate
    balances = calculate_balances
    simplify_debts(balances)
  end

  private

  def calculate_balances
    balances = Hash.new(0)

    # Get all expenses in the specified currency
    expenses = @trip.expenses.where(currency: @currency).includes(:expense_splits, :paid_by_user)

    expenses.each do |expense|
      # The payer is owed the full amount
      balances[expense.paid_by_user_id] += expense.amount

      # Each split participant owes their share
      expense.expense_splits.each do |split|
        balances[split.user_id] -= split.share_amount
      end
    end

    balances
  end

  def simplify_debts(balances)
    creditors = balances.select { |_, amount| amount > 0.01 }.sort_by { |_, amount| -amount }
    debtors = balances.select { |_, amount| amount < -0.01 }.sort_by { |_, amount| amount }

    settlements = []

    creditors.each do |creditor_id, credit|
      debtors.each do |debtor_id, debt|
        break if credit < 0.01

        amount = [credit, -debt].min
        next if amount < 0.01

        settlements << {
          from_user_id: debtor_id,
          to_user_id: creditor_id,
          amount: amount.round(2),
          currency: @currency
        }

        credit -= amount
        debt += amount
        debtors[debtors.index { |id, _| id == debtor_id }] = [debtor_id, debt]
      end
    end

    settlements
  end
end