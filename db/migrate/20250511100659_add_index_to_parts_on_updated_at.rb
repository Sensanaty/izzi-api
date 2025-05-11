class AddIndexToPartsOnUpdatedAt < ActiveRecord::Migration[7.1]
  def change
    add_index :parts, :updated_at
  end
end
