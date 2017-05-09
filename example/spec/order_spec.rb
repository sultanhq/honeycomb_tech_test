require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe Order do
  subject { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'empty' do
    it 'costs nothing' do
      expect(subject.subtotal).to eq(0)
    end
  end

  context 'with items' do
    it 'returns the subtotal cost of all items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery

      expect(subject.subtotal).to eq(30)
    end
  end

  context 'discounts' do
    it 'calculates a discount for two express deliveries' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, express_delivery
      subject.add broadcaster_2, express_delivery

      expect(subject.discounts).to eq(10.0)
    end

    it 'calculates a discount for order $30' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'Discovery')
      broadcaster_4 = Broadcaster.new(4, 'ITV')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, standard_delivery
      subject.add broadcaster_3, standard_delivery
      subject.add broadcaster_4, standard_delivery

      expect(subject.discounts).to eq(4.0)
    end

    it 'calculates a discount for order $30 and with 2 express deliveries' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'Discovery')

      subject.add broadcaster_1, express_delivery
      subject.add broadcaster_2, express_delivery
      subject.add broadcaster_3, standard_delivery

      expect(subject.discounts).to eq(14.0)
    end
  end
end

describe 'examples' do
  subject { Order.new material }
  let(:material) { Material.new 'WNP/SWCL001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'examples' do
    it 'Discount example 1' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'Discovery')
      broadcaster_4 = Broadcaster.new(7, 'Horse and Country')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, standard_delivery
      subject.add broadcaster_3, standard_delivery
      subject.add broadcaster_4, express_delivery

      expect(subject.total_cost).to eq(45.0)
    end

    it 'Discount example 2' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')
      broadcaster_3 = Broadcaster.new(3, 'Discovery')

      subject.add broadcaster_1, express_delivery
      subject.add broadcaster_2, express_delivery
      subject.add broadcaster_3, express_delivery

      expect(subject.total_cost).to eq(40.5)
    end
  end
end
