module PromotionalCheckout
  class LineItem
    attr_accessor :quantity
    attr_reader :product, :discounts

    def initialize(product)
      @product = product
      @quantity = 0
      @discounts = []
    end

    def total
      subtotal - @discounts.sum(&:amount)
    end

    def subtotal
      @product.price * @quantity
    end
  end
end
