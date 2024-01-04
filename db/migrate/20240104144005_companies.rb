class Companies < ActiveRecord::Migration[7.1]
  def change
    change_column_null :companies, :address, true
  end
end
