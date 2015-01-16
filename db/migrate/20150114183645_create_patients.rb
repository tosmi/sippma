class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :firstname, :null => false
      t.string :lastname, :null => false
      t.string :street, :null => false
      t.string :zip, :null => false
      t.string :city, :null => false
      t.date   :birthdate, :null => false
      t.string :email
      t.string :phonenumber1
      t.string :phonenumber2
      t.string :insurance, :null => false
      t.integer :ssn, :null => false

      t.timestamps null: false
    end
  end
end
