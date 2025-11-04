class AddGuestNameToExpenseSplits < ActiveRecord::Migration[7.1]
  def change
    # Add guest_name column
    add_column :expense_splits, :guest_name, :string

    # Make user_id nullable to allow guest splits
    change_column_null :expense_splits, :user_id, true

    # Remove old unique index
    remove_index :expense_splits, [:expense_id, :user_id]

    # Add partial unique index only for registered users (where user_id is not null)
    add_index :expense_splits, [:expense_id, :user_id], unique: true, where: "user_id IS NOT NULL"
  end
end
