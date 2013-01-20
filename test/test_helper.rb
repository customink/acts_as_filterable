require 'bundler/setup'
Bundler.require :default, :development, :test
require 'support/active_record_setup'
require 'support/active_record_models'
require 'minitest/autorun'

module ActsAsFilterable
  class TestCase < MiniTest::Spec
    
    include ActiveRecordSetup

    private

    def assert_identity_after_filter(filter, value)
      identity = value.object_id
      filter.call(value)
      identity.must_equal value.object_id
    end

  end  
end
