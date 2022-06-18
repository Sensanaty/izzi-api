class AddPartsToCompany < ActiveRecord::Migration[7.0]
  def change
    add_reference :parts, :company, null: false, index: true
  end
end
