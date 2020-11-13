require "test_helper"

class MainFlowTest < Minitest::Test
  Checkout = PromotionalCheckout::Checkout

  attr_reader :rules

  def setup
    PromotionalCheckout::ProductStub.create!(code: "A", price: 30)
    PromotionalCheckout::ProductStub.create!(code: "B", price: 20)
    PromotionalCheckout::ProductStub.create!(code: "C", price: 50)
    PromotionalCheckout::ProductStub.create!(code: "D", price: 15)
    @rules = [
      PromotionalCheckout::Rule.new("A", min_quantity: 3, amount_off: 15),
      PromotionalCheckout::Rule.new("B", min_quantity: 2, amount_off: 5),
      PromotionalCheckout::Rule.new(min_subtotal: 150, amount_off: 20),
      # PromotionalCheckout::Rule.new(min_subtotal: 100, percents_off: 20),
    ]
  end

  def test_a_b_c
    @codes = %w[A B C]

    assert_equal(100, price)
  end

  def test_b_a_b_a_a
    @codes = %w[B A B A A]

    assert_equal(110, price)
  end

  def test_c_b_a_a_d_a_b
    @codes = %w[C B A A D A B]

    assert_equal(155, price)
  end

  def test_c_a_d_a_a
    @codes = %w[C A D A A]

    assert_equal(140, price)
  end

  def _test_c_c_c
    @codes = %w[C C]

    assert_equal(80, price)
  end

  private

  def price
    co = Checkout.new(rules)
    @codes.each { |code| co.scan(code) }
    # pp co
    # puts $/
    price = co.total
  end
end
