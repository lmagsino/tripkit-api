class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :base_currency, null: false, default: 'PHP'
      t.string :active_currency, null: false, default: 'PHP'
      t.decimal :total_budget, precision: 10, scale: 2
      t.string :invite_code, null: false
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :trips, :invite_code, unique: true
  end
end