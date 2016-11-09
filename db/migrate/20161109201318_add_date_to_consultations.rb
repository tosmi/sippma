class AddDateToConsultations < ActiveRecord::Migration[5.0]
  def up
    add_column :consultations, :date, :datetime

    execute <<-SQL
    update consultations set date = created_at
    SQL

    change_column_null :consultations, :date, false
  end

  def down
    remove_column :consultations, :date
  end
end
