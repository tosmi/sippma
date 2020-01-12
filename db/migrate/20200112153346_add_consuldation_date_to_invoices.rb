class AddConsuldationDateToInvoices < ActiveRecord::Migration[5.2]
  def up
    add_column :invoices, :consuldation_date, :date

    connection.execute('update invoices set consuldation_date = date')

    change_column_null :invoices, :consuldation_date, false
  end

  def down
    remove_column :invoices, :consuldation_date
  end
end
