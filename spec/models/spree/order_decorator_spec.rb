require 'spec_helper'

describe Spree::Order do

  describe '.total_weight' do
    it 'gets the total weight of the line items' do
      order = Spree::Order.new
      (1..3).each do |i|
        line_item = stub_model(Spree::LineItem)
        line_item.stub(:total_weight) { i * 100 }
        order.line_items << line_item
      end
      order.total_weight.should == 600
    end
  end
end
