class CreateTripMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_memberships do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: 'member'
      t.datetime :joined_at, null: false

      t.timestamps
    end

    add_index :trip_memberships, [:trip_id, :user_id], unique: true
  end
end