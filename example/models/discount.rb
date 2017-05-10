class Discount
  attr_reader :percent, :percent_threshold, :express_delivery_discount, :express_delivery_threshold

  def initialize(args = {})
    @percent = (args[:percent] || 0).to_f
    @percent_threshold = args[:percent_threshold] || 0
    @express_delivery_discount = args[:express_delivery_discount] || 0
    @express_delivery_threshold = args[:express_delivery_threshold] || 0
  end

  def calculate_discount_value(items)
    order_value_subtotal = order_value(items)
    output = 0.0
    express_order_qty = items.count { |_, delivery| delivery.name == :express }
    if express_order_qty > express_delivery_threshold
      output += express_order_qty * express_delivery_discount
    end
    if order_value_subtotal > percent_threshold
      output += (order_value_subtotal - output) * (percent / 100)
    end
    output
  end

  private

  def order_value(items)
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end
end
