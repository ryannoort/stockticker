module CommodityTransactions
  class ValidateTransaction
    delegate :user, :commodity, :quantity, to: :commodity_transaction

    def self.call(...)
      new(...).call
    end

    def initialize(commodity_transaction:)
      @commodity_transaction = commodity_transaction
    end

    def call
      ActiveRecord::Base.transaction do
        set_price

        if commodity_transaction.purchase?
          return false unless validate_user_balance
          commodity_transaction.save!
          increase_commodity_ownership
        else
          return false unless validate_user_commodity_ownership
          commodity_transaction.save!
          decrease_commodity_ownership
        end
      end
    end

    private

    attr_reader :commodity_transaction

    def set_price
      commodity_transaction.price = commodity.price
    end

    def validate_user_balance
      return true if commodity_transaction.sale?

      # TODO: validate user has enough balance
      true
    end

    def validate_user_commodity_ownership
      return true if commodity_transaction.purchase?

      if ownership.new_record?
        @commodity_transaction.errors.add(:base, "You don't own any #{commodity.name}")
        return false
      elsif ownership.quantity < quantity
        @commodity_transaction.errors.add(:base, "You don't own enough #{commodity.name}")
        return false
      end

      true
    end

    def increase_commodity_ownership
      if ownership.new_record?
        ownership.quantity = quantity
        ownership.save!
      else
        ownership.increment!(:quantity, quantity)
      end
    end

    def decrease_commodity_ownership
      ownership.decrement!(:quantity, quantity)
    end

    def ownership
      @ownership ||= user.commodity_ownerships.find_or_initialize_by(commodity: commodity)
    end
  end
end
