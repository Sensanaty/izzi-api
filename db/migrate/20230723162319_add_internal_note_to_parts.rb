class AddInternalNoteToParts < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :internal_note, :string
  end
end
