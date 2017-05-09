require 'spec_helper'
require './models/discount.rb'
require './models/delivery'
require './models/material'
require './models/order'

describe 'Discounts' do
  subject { Discount.new order }
  let(:order) { Order.new material } #would normally use parenthesis
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'discounts' do
    it 'expects that a discount can be created' do
      expect(subject).to be_a_kind_of(Discount)
    end

    it 'expects that a discount can have and order value' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      order.add broadcaster_1, standard_delivery
      order.add broadcaster_2, express_delivery

      expect(subject.order_value).to eq(30)
    end
  end
end
