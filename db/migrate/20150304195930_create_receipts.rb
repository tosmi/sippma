class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :patient, index: true
      t.text :diagnosis
      t.float :totalfee
      t.string :receiptnumber, null: false
      t.date :date, null: false

      t.timestamps null: false
    end
    add_foreign_key :receipts, :patients
    add_index :receipts, [:patient_id, :created_at]
  end
end
