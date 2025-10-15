class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :trip, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :currency, null: false
      t.string :category, null: false
      t.text :description
      t.references :paid_by_user, null: false, foreign_key: { to_table: :users }
      t.string :split_type, null: false, default: 'equal'
      t.date :expense_date, null: false

      t.timestamps
    end

    add_index :expenses, :expense_date
    add_index :expenses, :category
  end
end