class Discount
  attr_reader :percent
  
  def initialize(order, percent=10)
    @order = order
    @percent = percent
  end

  def order_value
    @order.items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

end
