class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :parent_id, null: false
      t.integer :patient_id, null: false
      t.boolean :primary_contact, default: false

      t.timestamps null: false
    end
    add_index :relationships, :parent_id
    add_index :relationships, :patient_id
    add_index :relationships, [:parent_id, :patient_id], unique: true
  end
end
