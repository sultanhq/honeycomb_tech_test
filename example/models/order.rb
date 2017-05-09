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
    express_order_qty = items.count { |_, delivery| delivery.name == :express}
    if express_order_qty > 1
      discount_value = express_order_qty * 5.0
    end
    if subtotal - discount_value > 30
      discount_value += (subtotal - discount_value) * (10.0 / 100)
    end
    discount_value
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
