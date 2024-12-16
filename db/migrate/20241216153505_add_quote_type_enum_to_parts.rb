class AddQuoteTypeEnumToParts < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      UPDATE parts
      SET quote_type = 'outright_sale'
      WHERE quote_type IS NULL;
    SQL

    change_column_null :parts, :quote_type, false
  end

  def down
    change_column_null :parts, :quote_type, true
  end
end
