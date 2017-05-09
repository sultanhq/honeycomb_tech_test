class Discount

  def initialize(order)
    @order = order
  end

  def order_value
    @order.items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

end
