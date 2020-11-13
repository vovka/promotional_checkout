require "test_helper"

module PromotionalCheckout
  class LineItemTest < Minitest::Test
    def setup
      product = OpenStruct.new(price: 1.23)
      @line_item = LineItem.new(product)
      @line_item.quantity = 3
      @line_item.discounts << OpenStruct.new(amount: 0.69)
    end

    def test_subtotal
      assert_equal(3.69, @line_item.subtotal)
    end

    def test_total
      assert_equal(3, @line_item.total)
    end
  end
end
