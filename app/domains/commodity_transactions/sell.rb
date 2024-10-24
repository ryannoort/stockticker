module CommodityTransactions
  class Sell
    def self.call(user:, commodity:, quantity:, price:)
      new(user: user, commodity: commodity, quantity: quantity, price: price).call
    end

    def initialize(user:, commodity:, quantity:, price:)
      @user = user
      @commodity = commodity
      @quantity = quantity
      @price = price
    end

    def call
      ActiveRecord::Base.transaction do
        # TODO: validate customer has enough commodity
        create_commodity_transaction
        update_commodity_ownership
      end
    end

    private

    attr_reader :user, :commodity, :quantity, :price

    def create_commodity_transaction
      CommodityTransaction.create!(
        commodity: commodity,
        user: user,
        quantity: quantity,
        price: price,
        transaction_type: CommodityTransaction::TYPE_SALE
      )
    end

    def update_commodity_ownership

    end
  end
end
