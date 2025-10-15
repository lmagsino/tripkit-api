class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :document_type, null: false
      t.string :title, null: false
      t.text :notes
      t.references :uploaded_by_user, null: false, foreign_key: { to_table: :users }
      t.datetime :uploaded_at, null: false

      t.timestamps
    end

    add_index :documents, :document_type
  end
end