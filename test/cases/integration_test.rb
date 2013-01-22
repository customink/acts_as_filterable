require 'test_helper'

module ActsAsFilterable
  class IntegrationTest < TestCase

    let(:contact) { ContactDetail.new :name => "joe smith", :phone_number => "2223334444", :discount => 0.25 }

    it "should add an #apply_filters instance method" do
      contact.send(:apply_acts_as_filterable).must_equal true
    end

    it "should know about the types of filters that will be applied to the attributes and be unique to each class" do
      ContactDetail.filtered_attributes.must_equal({:digits => [:phone_number, :fax_number]})
      User.filtered_attributes.must_equal({:digits=>[:phone_number], :lowercase=>[:handle]})
    end

    it "should be savable with valid data and maintain that data" do
      assert contact.save
      contact.phone_number.must_equal "2223334444"
      contact.discount.must_equal 0.25
    end

    it "should strip all formatting" do
      contact.phone_number = "(222) 333-4444"
      contact.valid?
      contact.phone_number.must_equal "2223334444"
    end

    it "should return a coercable numeric value" do
      contact.phone_number = "(222) 333-4444"
      contact.valid?
      contact.phone_number.to_i.must_equal 2223334444
    end

    it "should not raise any errors due to a nil attribute value" do
      contact.phone_number = nil
      contact.valid?.must_equal true
    end

    it "should not attempt to change the attribute value" do
      contact.phone_number = nil
      contact.valid?
      contact.phone_number.must_be_nil
    end

    it "should not change the attribute value" do
      contact.phone_number = "5551212"
      contact.valid?
      contact.phone_number.must_equal "5551212"
    end

    it "should hold seperate collections of filtered_attributes" do
      User.filtered_attributes.wont_be_same_as ContactDetail.filtered_attributes
    end

    it 'allows attributs to come out of the database using filters too' do
      contact = ContactDetail.create!
      ContactDetail.update_all({:phone_number => "555-1212"}, {:id => contact.id})
      ContactDetail.first.phone_number.must_equal "5551212"
      ContactDetail.first.attributes['phone_number'].must_equal "5551212"
      ContactDetail.first.wont_be :changed?
    end

  end
end
