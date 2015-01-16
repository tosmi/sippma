class RemoveStringFromPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :string
  end
end
