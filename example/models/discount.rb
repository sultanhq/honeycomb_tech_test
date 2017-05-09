class Discount
  attr_reader :percent, :percent_threshold, :express_delivery_discount, :express_delivery_threshold

  def initialize(args)
    @items = args[:items]
    @percent = (args[:percent] || 0).to_f
    @percent_threshold = args[:percent_threshold] || 0
    @express_delivery_discount = args[:express_delivery_discount] || 0
    @express_delivery_threshold = args[:express_delivery_threshold] || 0
  end

  def order_value
    @items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def calculate_discount_value
    output = 0.0
    express_order_qty = @items.count { |_, delivery| delivery.name == :express}
    if express_order_qty > express_delivery_threshold
      output += express_order_qty * express_delivery_discount
    end
    if order_value > percent_threshold
      output += order_value * (percent / 100)
    end
    output
  end

end
