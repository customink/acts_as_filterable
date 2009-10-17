module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Base
      
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters
      end
      
      module ClassMethods
        
        def self.extended(klazz)
          klazz.filters.keys.each do |key|
            klazz.class_eval <<-MACROS, __FILE__, __LINE__ + 1
              def self.filter_for_#{key}(*args)
                filtered_attributes[:#{key}] |= args unless args.empty?
              end
            MACROS
          end
        end

        def filters
          @filters ||= returning Hash.new([]) do |f|
            f[:digits]    = lambda { |value| value.gsub!(/[^\d]*/, "") || value }
            f[:lowercase] = lambda { |value| value.downcase! || value }
          end.freeze
        end
        
        def filtered_attributes
          @filtered_attributes ||= Hash.new []
        end

      end
      
      protected
     
      def apply_filters
        self.class.filtered_attributes.each do |key, value|
          value.each do |attr|
            apply_filter self.class.filters[key], attr
          end
        end
      end
      
      private
      
      def apply_filter(filter, attr)
        if not self[attr].blank? and self[attr].is_a?(String)
          self[attr] = filter.call(self[attr])
        end
      end
            
    end
  
  end
  
end
