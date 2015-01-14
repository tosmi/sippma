class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :zip
      t.string :city
      t.string :string
      t.string :email
      t.string :phonenumber1
      t.string :phonenumber2
      t.string :insurance
      t.integer :ssn

      t.timestamps null: false
    end
  end
end
