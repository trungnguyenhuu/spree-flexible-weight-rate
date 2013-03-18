require 'spec_helper'

describe Spree::Calculator::FlexibleWeightRate do
  let(:calculator) do
    Spree::Calculator::FlexibleWeightRate.new do |f|
      f.preferred_first_500g = 4.55
      f.preferred_additional_500g = 1.25
    end
  end

  describe '.compute' do

    let(:order) { double ("Spree::Order") }
    subject { calculator.compute(order) }
    before(:each) { order.stub(:total_weight) { weight } }

    context 'less than 499g' do
      let(:weight) { 499 }
      it 'costs the first amount' do
        should == BigDecimal.new('4.55')
      end
    end

    context 'equal to 500g' do
      let(:weight) { 500 }
      it 'costs the first amount' do
        should == BigDecimal.new('4.55')
      end
    end

    context 'more than 500g, but less than 1000g' do
      let(:weight) { 501 }
      it 'costs the first amount + one additional amount' do
        should == BigDecimal.new('5.80')
      end
    end

    context 'equal to 1000g' do
      let(:weight) { 1000 }
      it 'costs the first amount + one additional amount' do
        should == BigDecimal.new('5.80')
      end
    end

    context 'more than 1000g' do
      let(:weight) { 1752.1231444 }
      it 'costs the first amount + an additional amount per 500g' do
        should == BigDecimal.new('8.30')
      end
    end
  end

  describe '.description' do
    specify { Spree::Calculator::FlexibleWeightRate.description.should_not be_nil }
  end

  describe '.available?' do
    specify { Spree::Calculator::FlexibleWeightRate.available?(Object.new).should be_true }
  end
end
