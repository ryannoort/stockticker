class CreateCommodities < ActiveRecord::Migration[8.0]
  def change
    create_table :commodities do |t|
      t.string :name, index: { unique: true }
      t.integer :price, precision: 3

      t.timestamps
    end
  end
end
