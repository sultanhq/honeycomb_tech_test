require 'spec_helper'
require './models/discount.rb'
require './models/delivery'
require './models/material'
require './models/order'

describe 'Discounts' do
  subject { Discount.new order: order }
  let(:order) { Order.new material } # would normally use parenthesis
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'discounts' do
    it 'expects that a discount can be created' do
      expect(subject).to be_a_kind_of(Discount)
    end

    it 'expects that a discount has a discount value of 0 when no discounts are defined' do
      expect(subject.discount_value).to eq(0)
    end

    it 'expects that a discount can have and order value' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      order.add broadcaster_1, standard_delivery
      order.add broadcaster_2, express_delivery

      expect(subject.order_value).to eq(30)
    end

    context 'Percentage discount' do
      it 'expects that a discount can have a default percentage discount value of 0' do
        expect(subject.percent).to eq(0.0)
      end

      it 'expects that a discount can have a percentage of 25 defined' do
        discount2 = Discount.new(order: order, percent: 25)
        expect(discount2.percent).to eq(25)
      end

      it 'expects that a discount can have a default percentage threshold of of 0' do
        expect(subject.percent_threshold).to eq(0)
      end

      it 'expects that a discount can have a percentage threshold of $30 defined' do
        discount2 = Discount.new(order: order, percent_threshold: 30)
        expect(discount2.percent_threshold).to eq(30)
      end

      context 'Example' do
        it 'expects that an order can have a percent discount value of $10' do
          discount2 = Discount.new(order: order, percent: 25, percent_threshold: 30)
          broadcaster_1 = Broadcaster.new(1, 'Viacom')
          broadcaster_2 = Broadcaster.new(2, 'Disney')
          broadcaster_3 = Broadcaster.new(3, 'Discovery')

          order.add broadcaster_1, standard_delivery
          order.add broadcaster_2, express_delivery
          order.add broadcaster_3, standard_delivery

          expect(discount2.discount_value).to eq(10.0)
        end
      end
    end

    context 'Delivery Discount' do
      it 'expects that a discount can have a default multiple express delivery discount value of 0' do
        expect(subject.express_delivery_discount).to eq(0)
      end

      it 'expects that a discount can have a multiple express delivery discount of $5 defined' do
        discount3 = Discount.new(order: order, express_delivery_discount: 5)
        expect(discount3.express_delivery_discount).to eq(5)
      end

      it 'expects that a discount can have a multiple express delivery order quantity threshold of 0' do
        expect(subject.express_delivery_threshold).to eq(0)
      end

      it 'expects that a discount can have a multiple express delivery order quantity threshold 2 defined' do
        discount3 = Discount.new(order: order, express_delivery_threshold: 1)
        expect(discount3.express_delivery_threshold).to eq(1)
      end
      context 'Example' do
        it 'expects that an order can have a multi delivery discount value of $14' do
          discount3 = Discount.new(order: order, express_delivery_discount: 7, express_delivery_threshold: 1)
          broadcaster_1 = Broadcaster.new(1, 'Viacom')
          broadcaster_2 = Broadcaster.new(2, 'Disney')
          broadcaster_3 = Broadcaster.new(3, 'Discovery')

          order.add broadcaster_1, standard_delivery
          order.add broadcaster_2, express_delivery
          order.add broadcaster_3, express_delivery

          expect(discount3.discount_value).to eq(14.0)
        end
      end
    end

    context 'Percent and Delivery Discount' do
      context 'Example' do
        it 'expects that an order can have percentage and multi delivery discount value of $26.5  ' do
          discount4 = Discount.new(order: order, percent: 25, percent_threshold: 30, express_delivery_discount: 7, express_delivery_threshold: 1)
          broadcaster_1 = Broadcaster.new(1, 'Viacom')
          broadcaster_2 = Broadcaster.new(2, 'Disney')
          broadcaster_3 = Broadcaster.new(3, 'Discovery')

          order.add broadcaster_1, standard_delivery
          order.add broadcaster_2, express_delivery
          order.add broadcaster_3, express_delivery

          expect(discount4.discount_value).to eq(26.5)
        end
      end
    end
  end
end
