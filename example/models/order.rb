class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items

  def initialize(material, discount)
    self.material = material
    self.items = []
    @discount = discount
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def subtotal
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def total_cost
    subtotal - @discount.calculate_discount_value(items)
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
      result << "Discounts: $#{@discount.calculate_discount_value(items)}"
      result << "Total: $#{total_cost}"
    end.join("\n")
  end

  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
