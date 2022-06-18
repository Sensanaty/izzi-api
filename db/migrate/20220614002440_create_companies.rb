class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city
      t.string :country
      t.string :website
      t.string :type
      t.string :subscription

      t.timestamps
    end
  end
end
