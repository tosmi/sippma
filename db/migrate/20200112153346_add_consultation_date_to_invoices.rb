class AddConsultationDateToInvoices < ActiveRecord::Migration[5.2]
  def up
    add_column :invoices, :consultation_date, :date

    connection.execute('update invoices set consultation_date = date')

    change_column_null :invoices, :consultation_date, false
  end

  def down
    remove_column :invoices, :consultation_date
  end
end
