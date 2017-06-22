class CreateConsultations < ActiveRecord::Migration[5.1]
  def change
    create_table :consultations do |t|
      t.text :content
      t.text :diagnosis
      t.references :patient, index: true

      t.timestamps null: false
    end
    add_foreign_key :consultations, :patients

    add_index :consultations, [:patient_id, :created_at]
  end
end
