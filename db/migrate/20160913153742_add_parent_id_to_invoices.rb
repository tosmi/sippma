class AddParentIdToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :parent_id, :integer
  end
end
