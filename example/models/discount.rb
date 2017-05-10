class Discount
  attr_reader :percent, :percent_threshold, :express_delivery_discount, :express_delivery_threshold

  def initialize(args = {})
    @percent = (args[:percent] || 0).to_f
    @percent_threshold = args[:percent_threshold] || 0
    @express_delivery_discount = args[:express_delivery_discount] || 0
    @express_delivery_threshold = args[:express_delivery_threshold] || 0
  end

  def calculate_discount_value(items)
    discount_value = 0.0
    discount_value += calculate_delivery_discount(items)
    discount_value += calculate_percent_discount(items, discount_value)
  end

  private

  def calculate_delivery_discount(items)
    express_order_qty = items.count { |_, delivery| delivery.name == :express }
    delivery_discount = 0.0
    if express_order_qty > express_delivery_threshold
      delivery_discount += express_order_qty * express_delivery_discount
    end
    delivery_discount
  end

  def calculate_percent_discount(items, discount_value)
    order_value= items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
    percent_discount = 0.0
    if order_value > percent_threshold
      percent_discount += (order_value - discount_value) * (percent / 100)
    end
    percent_discount
  end

end
