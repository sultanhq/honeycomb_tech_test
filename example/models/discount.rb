class Discount
  attr_reader :percent, :percent_threshold

  def initialize(args)
    @order = args[:order]
    @percent = (args[:percent] || 0).to_f
    @percent_threshold = args[:percent_threshold] || 0
  end

  def order_value
    @order.items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def discount_value
    output = 0.0
    if order_value > percent_threshold
      output = order_value * (percent / 100)
    end
    output
  end

end
