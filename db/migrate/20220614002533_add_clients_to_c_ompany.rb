class AddClientsToCOmpany < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :company, null: false, index: true
  end
end
