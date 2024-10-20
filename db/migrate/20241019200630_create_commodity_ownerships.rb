class CreateCommodityOwnerships < ActiveRecord::Migration[8.0]
  def change
    create_table :commodity_ownerships do |t|
      t.references :commodity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
