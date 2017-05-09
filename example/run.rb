#!/usr/bin/env ruby

require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

standard_delivery = Delivery.new(:standard, 10.0)
express_delivery = Delivery.new(:express, 20.0)

broadcaster_1 = Broadcaster.new(1, 'Viacom')
broadcaster_2 = Broadcaster.new(2, 'Disney')
broadcaster_3 = Broadcaster.new(3, 'Discovery')
broadcaster_4 = Broadcaster.new(4, 'ITV')
broadcaster_5 = Broadcaster.new(5, 'Channel 4')
broadcaster_6 = Broadcaster.new(6, 'Bike Channel')
broadcaster_7 = Broadcaster.new(7, 'Horse and Country')

discount = Discount.new(percent: 10, percent_threshold: 30, express_delivery_discount: 5, express_delivery_threshold: 1)

material = Material.new('WNP/SWCL001/010')

order = Order.new(material, discount)

order.add broadcaster_1, standard_delivery
order.add broadcaster_2, standard_delivery
order.add broadcaster_3, express_delivery

print order.output
print "\n"
print "\n"

material2 = Material.new('ZDW/EOWW005/010')

order2 = Order.new(material2, discount)

order2.add broadcaster_1, standard_delivery
order2.add broadcaster_2, express_delivery
order2.add broadcaster_3, express_delivery

print order2.output
print "\n"
