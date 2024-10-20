class AddQuantityConstraintToCommodityOwnership < ActiveRecord::Migration[8.0]
  def change
    execute <<-SQL
      ALTER TABLE commodity_ownerships
      ADD CONSTRAINT quantity_check CHECK (quantity >= 0)
    SQL
  end
end
