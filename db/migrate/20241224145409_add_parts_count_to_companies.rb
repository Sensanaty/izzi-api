class AddPartsCountToCompanies < ActiveRecord::Migration[7.1]
  def up
    add_column :companies, :parts_count, :integer, default: 0, null: false

    Company.find_each(batch_size: 100) do |company|
      Company.reset_counters(company.id, :parts)
    end
  end

  def down
    remove_column :companies, :parts_count
  end
end
