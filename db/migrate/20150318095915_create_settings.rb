class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :zip
      t.string :city
      t.string :email
      t.string :phonenumber
      t.integer :initial_receiptnumber
      t.integer :current_receiptnumber

      t.timestamps null: false
    end
  end
end
