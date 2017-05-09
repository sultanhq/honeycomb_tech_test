require 'spec_helper'
require './models/discount.rb'

describe 'Discounts' do
  subject { Discount.new  }

  context 'discounts' do
    it 'expects that a discount can be created' do
      expect(subject).to be_a_kind_of(Discount)
    end
  end
end
