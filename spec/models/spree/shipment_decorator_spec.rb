describe Spree::Shipment do
  describe '.total_weight' do
    it 'returns total order weight' do
      shipment = Spree::Shipment.new
      shipment.order = mock_model(Spree::Order)
      shipment.order.stub(:total_weight) { 343 }
      shipment.total_weight.should == 343
    end
  end
end
