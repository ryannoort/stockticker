class CreateCommodityAdjustments < ActiveRecord::Migration[8.0]
  def change
    create_table :commodity_adjustments do |t|
      t.references :commodity, null: false, foreign_key: true
      t.integer :price_change, null: false

      t.timestamps
    end
  end
end
