class CreateEntryLines < ActiveRecord::Migration
  def change
    create_table :entry_lines do |t|
      t.references :receipt, index: true
      t.text :text
      t.float :fee

      t.timestamps null: false
    end
    add_foreign_key :entry_lines, :receipts
  end
end
