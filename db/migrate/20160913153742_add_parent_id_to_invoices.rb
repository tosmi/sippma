class AddParentIdToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :parent_id, :integer
  end
end
