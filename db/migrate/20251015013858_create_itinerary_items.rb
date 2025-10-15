class CreateItineraryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :itinerary_items do |t|
      t.references :trip, null: false, foreign_key: true
      t.date :date, null: false
      t.time :time
      t.string :title, null: false
      t.string :location
      t.text :notes
      t.string :category, null: false, default: 'activity'
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :itinerary_items, :date
    add_index :itinerary_items, :category
  end
end