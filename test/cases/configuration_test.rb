require 'test_helper'

module ActsAsFilterable
  class ConfigurationTest < TestCase

    it 'has a config instance' do
      ActsAsFilterable.config.must_be_instance_of Configuration
    end

    it 'yields the config instance via a configure block' do
      ActsAsFilterable.configure do |config|
        config.object_id.must_equal ActsAsFilterable.config.object_id
      end
    end

    describe 'dummy application filter additions' do

      let(:order_item_empty) { OrderItem.create!.reload }
      let(:order_item_good)  { OrderItem.create!(:quantity => 2, :unit_price => 22.0).reload }

      it 'adds them to the class' do
        filtered_attributes = {:default_zero=>[:quantity], :default_price=>[:unit_price], :integer_cast=>[:total]}
        OrderItem.filtered_attributes.must_equal filtered_attributes
      end

      it 'works for instances' do
        order_item_empty.quantity.must_equal 0
        order_item_empty.unit_price.must_equal 0.0
        order_item_good.quantity.must_equal 2
        order_item_good.unit_price.must_equal 22.0
      end

    end

  end
end
