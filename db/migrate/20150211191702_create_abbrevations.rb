class CreateAbbrevations < ActiveRecord::Migration[5.1]
  def change
    create_table :abbrevations do |t|
      t.string :abbrev
      t.string :text

      t.timestamps null: false
    end
  end
end
