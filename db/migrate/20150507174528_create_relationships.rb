class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :parent_id, null: false
      t.integer :child_id, null: false
      t.boolean :primary_contact, default: false

      t.timestamps null: false
    end
    add_index :relationships, :parent_id
    add_index :relationships, :child_id
    add_index :relationships, [:parent_id, :child_id], unique: true
  end
end
