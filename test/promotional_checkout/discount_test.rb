require "test_helper"

module PromotionalCheckout
  class DiscountTest < Minitest::Test
    def setup
      @discount = Discount.new("some rule instance", 123.45)
    end

    def test_amount_is_a_money
      assert_instance_of(Money, @discount.amount)
    end
  end
end
