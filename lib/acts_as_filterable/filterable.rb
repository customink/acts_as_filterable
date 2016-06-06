module ActsAsFilterable
  module Filterable

    extend ActiveSupport::Concern

    included do
      class_attribute :filtered_attributes
      self.filtered_attributes = Hash.new
      before_validation :apply_acts_as_filterable
      extend ClassMethods
    end

    module ClassMethods

      private

      def generate_aaf_attribute_methods(filter_name, *attribs)
        mod = Module.new
        mod.module_eval <<-RUBY, __FILE__, __LINE__
          def attributes
            super.tap do |hash|
              #{attribs}.each do |attrib|
                next unless hash.key? attrib.to_s
                value = hash[attrib.to_s]
                hash[attrib.to_s] = ActsAsFilterable.filtering['#{filter_name}'].call(value)
              end
            end
          end
        RUBY
        attribs.each do |attrib|
          mod.module_eval <<-RUBY, __FILE__, __LINE__
            def #{attrib}
              ActsAsFilterable.filtering['#{filter_name}'].call(super)
            end
          RUBY
        end
        include(mod)
      end

    end

    private

    def apply_acts_as_filterable
      self.class.filtered_attributes.each do |name, attribs|
        attribs.each do |attrib|
          apply_acts_as_filter attrib, ActsAsFilterable.filtering[name]
        end
      end
      true
    end

    def apply_acts_as_filter(attrib, filter)
      data = send(attrib)
      filter.call(data) if data.is_a?(String)
    end

  end
end
