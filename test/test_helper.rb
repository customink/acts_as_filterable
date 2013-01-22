require 'dummy_app/init'
require 'minitest/autorun'

module ActsAsFilterable
  class TestCase < MiniTest::Spec
    
    include DummyAppConcerns

    private

    def assert_same_object_id_after_filter(filter, value)
      identity = value.object_id
      filter.call(value)
      identity.must_equal value.object_id
    end

  end  
end
