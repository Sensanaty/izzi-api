# This migration creates the `versions` table, the only schema paper_trail requires.
# All other migrations PT provides are optional.
class CreateVersions < ActiveRecord::Migration[7.1]
  def change
    create_table :versions do |t|
      # Consider using bigint type for performance if you are going to store only numeric ids.
      t.bigint   :whodunnit

      t.datetime :created_at

      t.bigint   :item_id,   null: false
      t.string   :item_type, null: false
      t.string   :event,     null: false
      t.jsonb    :object
      t.jsonb    :object_changes
    end

    add_index :versions, %i[item_type item_id]
  end
end
