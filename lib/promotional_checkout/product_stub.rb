module PromotionalCheckout
  class ProductStub
    def self.create!(attributes)
      @products ||= []
      attributes[:price] = Money.from_amount(attributes[:price])
      @products << OpenStruct.new(attributes)
    end

    def self.find_by_code(code)
      @products.find { |product| product.code == code }
    end
  end
end
