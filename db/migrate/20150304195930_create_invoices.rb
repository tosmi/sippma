class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :patient, index: true
      t.text :diagnosis
      t.float :totalfee
      t.string :invoicenumber, null: false
      t.date :date, null: false

      t.timestamps null: false
    end

    add_foreign_key :invoices, :patients
    add_index :invoices, [:patient_id, :created_at]
  end
end
