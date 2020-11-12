module PromotionalCheckout
  class Rule
    attr_reader :type

    def initialize
      @type = ["basket", "item"].sample
    end

    def apply_to(checkout_item)
      checkout_item.promotional_rules << self
    end
  end
end
