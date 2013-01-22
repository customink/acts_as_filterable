module ActsAsFilterable 
  module Base

    extend ActiveSupport::Concern

    included do
      extend ClassMethods
    end

    module ClassMethods

      def acts_as_filterable(name, *attribs)
        include Filterable unless respond_to? :filtered_attributes
        self.filtered_attributes[name] ||= []
        self.filtered_attributes[name] |= attribs unless attribs.empty?
        generate_aaf_attribute_methods(name, *attribs) if Util.rails30? || Util.rails31?
      end

    end

  end
end

ActiveRecord::Base.send :include, ActsAsFilterable::Base
