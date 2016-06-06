module ActsAsFilterable
  module Base

    extend ActiveSupport::Concern

    included do
      extend ClassMethods
    end

    module ClassMethods

      def acts_as_filterable(filter_name, *attribs)
        include Filterable unless respond_to? :filtered_attributes
        self.filtered_attributes[filter_name] ||= []
        self.filtered_attributes[filter_name] |= attribs unless attribs.empty?
        generate_aaf_attribute_methods(filter_name, *attribs)
      end

    end

  end
end

ActiveRecord::Base.send :include, ActsAsFilterable::Base
