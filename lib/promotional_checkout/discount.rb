module PromotionalCheckout
  class Discount
    attr_reader :amount

    def initialize(rule, amount)
      @rule = rule
      @amount = Money.from_amount(amount)
    end
  end
end
