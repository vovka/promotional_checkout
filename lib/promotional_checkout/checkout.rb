module PromotionalCheckout
  class Checkout
    def initialize(rules, products = ProductStub)
      @item_promotion_rules = rules.select { |r| r.type == "item" }
      @basket_promotion_rules = rules.select { |r| r.type == "basket" }
      @items = []
      @products = products
    end

    def scan(product_code)
      product = @products.find_by_code(product_code)
      checkout_item = Item.new(product)
      @items << @item_promotion_rules.reduce(checkout_item) { |item, promotion_rule| promotion_rule.apply_to(checkout_item) }
    end

    def total
      subtotal = @items.sum(&:total)
      @basket_promotion_rules.reduce(subtotal) { |subt, promotion_rule| promotion_rule.apply_to(subt) }
    end
  end
end
