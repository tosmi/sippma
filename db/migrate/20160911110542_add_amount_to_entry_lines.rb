class AddAmountToEntryLines < ActiveRecord::Migration[5.1]
  def change
    add_column :entry_lines, :amount, :integer
  end
end
