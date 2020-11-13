module PromotionalCheckout
  class Checkout
    attr_reader :line_items, :discounts

    def initialize(rules, products = ProductStub)
      @rules = rules
      @line_items = []
      @products = products
      @discounts = []
    end

    def scan(product_code)
      product = @products.find_by_code(product_code)
      return if product.nil?
      line_item = @line_items.find { |li| li.product == product }
      if line_item.nil?
        line_item = LineItem.new(product)
        @line_items << line_item
      end
      line_item.quantity += 1
      product
    end

    def total
      @rules.each { |rule| rule.apply_to(self) }
      subtotal - total_discount
    end

    def subtotal
      @line_items.sum(&:total)
    end

    def total_discount
      @discounts.sum(&:amount)
    end
  end
end
