class CreateParts < ActiveRecord::Migration[7.0]
  def change
    create_table :parts do |t|
      t.string :part_number, null: false
      t.string :description, null: false
      t.integer :available, null: false, default: 0
      t.integer :reserved, null: false, default: 0
      t.integer :sold, null: false, default: 0
      t.string :condition, null: false
      t.integer :min_cost, default: 0
      t.integer :min_price, default: 0
      t.integer :min_order, default: 0
      t.integer :med_cost, default: 0
      t.integer :med_price, default: 0
      t.integer :med_order, default: 0
      t.integer :max_cost, default: 0
      t.integer :max_price, default: 0
      t.integer :max_order, default: 0
      t.string :lead_time
      t.string :quote_type
      t.string :tag, null: false
      t.date :added, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
