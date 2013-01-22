module ActsAsFilterable

  class Filtering

    class NoFilterBlockGiven < Error
      def message
        "Must supply a block when adding a filter to ActsAsFilterable."
      end
    end

    def initialize
      @filters = Hash.new
      add_default_filters
    end

    def add_filter(name, &block)
      raise NoFilterBlockGiven unless block_given?
      @filters[name] = block
    end

    def [](name)
      @filters[name.to_sym]
    end


    private

    def add_default_filters
      add_filter :digits,     &default_digit_filter
      add_filter :lowercase,  &default_lowercase_filter
      add_filter :uppercase,  &default_uppercase_filter
      add_filter :whitespace, &default_whitespace_filter
    end

    def default_digit_filter
      lambda do |value|
        return if value.nil?
        if value.kind_of?(Numeric)
          value.to_s.gsub!(/[^\d]*/, "")
          value.to_i
        else
          value.gsub!(/[^\d]*/, "")
          value
        end
      end
    end

    def default_lowercase_filter
      lambda do |value|
        return if value.nil?
        if value.is_a?(String)
          value.downcase!
          value
        else 
          value.to_s.downcase
        end
      end
    end

    def default_uppercase_filter
      lambda do |value|
        return if value.nil?
        if value.is_a?(String)
          value.upcase!
          value
        else 
          value.to_s.upcase
        end
      end
    end

    def default_whitespace_filter
      lambda do |value|
        return if value.nil?
        if value.is_a?(String)
          value.gsub!(/\s+/, " ")
          value.strip!
          value
        else 
          value.to_s.gsub(/\s+/, " ").strip
        end
      end
    end

  end

  def self.filtering
    @filtering ||= Filtering.new
  end

end
