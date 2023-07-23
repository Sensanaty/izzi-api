class ChangeFloatPrecisionForCostAndPrice < ActiveRecord::Migration[7.0]
  def up
    change_table :parts do |t|
      t.change :min_cost, :decimal, precision: 15, scale: 2, default: 0.00
      t.change :min_price, :decimal, precision: 15, scale: 2, default: 0.00
      t.change :med_cost, :decimal, precision: 15, scale: 2, default: 0.00
      t.change :med_price, :decimal, precision: 15, scale: 2, default: 0.00
      t.change :max_cost, :decimal, precision: 15, scale: 2, default: 0.00
      t.change :max_price, :decimal, precision: 15, scale: 2, default: 0.00
    end
  end

  def down
    change_table :parts do |t|
      t.change :min_cost, :decimal, precision: 15, scale: 3, default: 0.000
      t.change :min_price, :decimal, precision: 15, scale: 3, default: 0.000
      t.change :med_cost, :decimal, precision: 15, scale: 3, default: 0.000
      t.change :med_price, :decimal, precision: 15, scale: 3, default: 0.000
      t.change :max_cost, :decimal, precision: 15, scale: 3, default: 0.000
      t.change :max_price, :decimal, precision: 15, scale: 3, default: 0.000
    end
  end
end
