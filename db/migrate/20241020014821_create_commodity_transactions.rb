class CreateCommodityTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :commodity_transactions do |t|
      t.references :commodity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :price, null: false
      t.string :transaction_type, null: false

      t.timestamps
    end
  end
end
