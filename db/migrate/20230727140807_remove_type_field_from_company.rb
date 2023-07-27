class RemoveTypeFieldFromCompany < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :type
  end
end
