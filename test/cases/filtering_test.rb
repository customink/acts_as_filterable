require 'test_helper'

module ActsAsFilterable
  class FilteringTest < TestCase

    let(:filtering) { ActsAsFilterable.filtering }
    let(:filters)   { filtering.instance_variable_get(:@filters) }

    it "have empty values for names in filters" do
      filters.key?(:test).must_equal false
      filters[:test].must_be_nil
    end

    it "should contain some filters initially" do
      filters.key?(:digits).must_equal    true
      filters.key?(:lowercase).must_equal true
    end

    describe '#add_filter' do

      it 'raises an error if no block given' do
        lambda{ filtering.add_filter(:foo) }.must_raise Filtering::NoFilterBlockGiven
      end

    end

    describe 'digits' do

      it "should strip any non-digit values from the string" do
        value = "45tr.,2"
        filters[:digits].call(value)
        value.must_equal "452"
      end

      it "should not lose digit values" do
        value = "432099132"
        filters[:digits].call(value)
        value.must_equal "432099132"
      end

      it "should return a coercable numerica value" do
        value = "4"
        filters[:digits].call(value)
        value.to_i.must_equal 4
      end

      it "should not create extra string objects when replacing values" do
        assert_same_object_id_after_filter filters[:digits], "54tr"
      end

      it "should not create extra string objects when no values are to be replaced" do
        assert_same_object_id_after_filter filters[:digits], "54"
      end

    end

    describe 'lower' do

      it "should lowercase all alpha values" do
        value = "FAIl STRING"
        filters[:lowercase].call(value)
        value.must_equal "fail string"
      end

      it "should not create extra string objects when replacing values" do
        assert_same_object_id_after_filter filters[:lowercase], "TRANSLATE"
      end

      it "should not create extra string objects when no values are to be replaced" do
        assert_same_object_id_after_filter filters[:lowercase], "43"
      end

    end

    describe 'uppercase' do

      it "should uppercase all alpha values" do
        value = "lowercase string"
        filters[:uppercase].call(value)
        value.must_equal "LOWERCASE STRING"
      end

      it "should not create extra string objects when replacing values" do
        assert_same_object_id_after_filter filters[:uppercase], "translate"
      end

      it "should not create extra string objects when no values are to be replaced" do
        assert_same_object_id_after_filter filters[:uppercase], "43"
      end

    end

    describe 'whitespace' do

      it "should replace all un-neccessary whitespace" do
        value = "\t hai!    this is neat\n\nok?  \t"
        filters[:whitespace].call(value)
        value.must_equal "hai! this is neat ok?"
      end

      it "should trim the ends of the string" do
        value = " this "
        filters[:whitespace].call(value)
        value.must_equal "this"
      end

      it "should not create extra string objects when replacing values" do
        assert_same_object_id_after_filter filters[:whitespace], "TRANSLATE"
      end

      it "should not create extra string objects when no values are to be replaced" do
        assert_same_object_id_after_filter filters[:whitespace], "43"
      end

    end

  end  
end
