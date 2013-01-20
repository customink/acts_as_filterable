module ActsAsFilterable
  module ActiveRecordSetup

    extend ActiveSupport::Concern

    included do
      before { setup_active_record_schema }
      ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'
      ActiveRecord::Migration.verbose = false
    end

    def setup_active_record_schema
      ActiveRecord::Base.class_eval do
        connection.instance_eval do
          create_table :contact_details, :force => true do |t|
            t.string :name
            t.string :phone_number
            t.string :fax_number
            t.float :discount
          end
          create_table :users, :force => true do |t|
            t.string :handle
            t.string :phone_number
          end
        end
      end
    end
    
  end
end