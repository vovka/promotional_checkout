module PromotionalCheckout
  class Rule
    def initialize(item = nil, min_quantity: nil, min_subtotal: nil, amount_off: nil, percents_off: nil)
      @item = item
      @min_quantity = min_quantity
      @min_subtotal = min_subtotal
      @amount_off = amount_off
      @percents_off = percents_off
    end

    def apply_to(checkout)
      if @item.nil?
        apply_basket_discount(checkout)
      else
        apply_item_discount(checkout)
      end
      checkout
    end

    private

    def apply_basket_discount(checkout)
      return unless appliable?(checkout)
      checkout.discounts << Discount.new(self, evaluate_amount(checkout))
    end

    def apply_item_discount(checkout)
      line_item = checkout.line_items.find { |li| li.product.code == @item }
      return if line_item.nil?
      return unless appliable?(line_item)
      line_item.discounts << Discount.new(self, evaluate_amount(line_item))
    end

    def appliable?(object)
      return object.quantity >= @min_quantity unless @min_quantity.nil?
      return object.subtotal >= @min_subtotal unless @min_subtotal.nil?
    end

    def evaluate_amount(object)
      return @amount_off unless @amount_off.nil?
      object.subtotal / 100 * @percents_off
    end
  end
end
