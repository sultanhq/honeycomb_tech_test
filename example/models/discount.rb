class Discount
  attr_reader :percent

  def initialize(args)
    @order = args[:order]
    @percent = args[:percent]|| 0
  end

  def order_value
    @order.items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

end
