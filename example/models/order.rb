class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items

  def initialize(material)
    self.material = material
    self.items = []
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def subtotal
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def discounts
    discount_value = 0.0
    discount_value += express_multiple_discount
    discount_value += order_value_discount(discount_value)
  end

  def express_multiple_discount
    express_discount_value = 0.0
    express_order_qty = items.count { |_, delivery| delivery.name == :express}
    if express_order_qty > 1
      express_discount_value = express_order_qty * 5.0
    end
    express_discount_value
  end

  def order_value_discount(input)
    output = 0.0
    if subtotal - input > 30
      output += (subtotal - input) * (10.0 / 100)
    end
    output
  end

  def total_cost
    subtotal - discounts
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Sub-Total: $#{subtotal}"
      result << "Discounts: $#{discounts}"
      result << "Total: $#{total_cost}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
