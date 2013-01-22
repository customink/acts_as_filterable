ENV['RAILS_ENV'] = 'test'
require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../../Gemfile', __FILE__)
require 'bundler/setup'
require 'rails/all'
Bundler.require :default, :development, :test

module Dummy
  class Application < ::Rails::Application 

    config.root = File.join __FILE__, '..'
    config.active_support.deprecation = :stderr
    config.cache_store = :memory_store
    config.consider_all_requests_local = true
    config.eager_load = true
    
  end
end

Dummy::Application.initialize!

module ActsAsFilterable
  module DummyAppConcerns

    extend ActiveSupport::Concern

    included do
      before { setup_active_record_schema }
    end

    private

    def setup_active_record_schema
      ActiveRecord::Base.class_eval do
        connection.instance_eval do
          create_table :contact_details, :force => true do |t|
            t.string :name
            t.string :phone_number
            t.string :fax_number
            t.float :discount
            t.datetime :created_at
            t.datetime :updated_at
          end
          create_table :users, :force => true do |t|
            t.string :handle
            t.string :phone_number
            t.string :first_name
            t.string :last_name
            t.datetime :created_at
            t.datetime :updated_at
          end
          create_table :accounts, :force => true do |t|
            t.string :first_name
            t.string :last_name
            t.datetime :created_at
            t.datetime :updated_at
          end
          create_table :order_items, :force => true do |t|
            t.integer :quantity
            t.decimal :unit_price, :precision => 15, :scale => 2
            t.string  :total
            t.datetime :created_at
            t.datetime :updated_at
          end
        end
      end
    end
    
  end
end
