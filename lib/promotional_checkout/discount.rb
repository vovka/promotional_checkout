module PromotionalCheckout
  class Discount
    attr_reader :amount

    def initialize(rule, amount)
      @rule = rule
      @amount = amount
    end
  end
end
