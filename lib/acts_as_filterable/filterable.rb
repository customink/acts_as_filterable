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

      def filtered_attributes_for_attribute(attr_name)
        return [] unless attr_name
        filtered_attributes.select{ |name, attribs| attribs.include?(attr_name.to_sym) }
      end

      def acts_as_filterable_cast_code(name, var_name='v')
        "ActsAsFilterable.filtering['#{name}'].call(#{var_name})"
      end

      private

      def generate_aaf_attribute_methods(name, *attribs)
        attribs.each do |attrib|
          attrib = attrib.to_s
          define_method_attribute(attrib)
          column = columns_hash[attrib]
          column_cast_code = column.type_cast_code('v') if column
          access_code  = %|begin|
          access_code << %|; v = @attributes['#{attrib}']|
          access_code << %|; v = #{column_cast_code}| if column_cast_code.present?
          access_code << %|; v = #{acts_as_filterable_cast_code(name)}|
          access_code << %|; v|
          access_code << %|; end|
          access_code = "@attributes_cache['#{attrib}'] ||= (#{access_code})" if cache_attribute?(attrib)
          generated_attribute_methods.module_eval <<-RUBY, __FILE__, __LINE__ + 1
            undef :_#{attrib} if method_defined?('_#{attrib}')
            undef :#{attrib} if method_defined?('#{attrib}')
            def _#{attrib}
              #{access_code}
            end
            alias #{attrib} _#{attrib}
          RUBY
        end
      end

      def attribute_cast_code(attr_name)
        super.tap do |code|
          filtered_attributes_for_attribute(attr_name).each do |name, attribs|
            code << "; #{acts_as_filterable_cast_code(name)}"
          end
        end
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