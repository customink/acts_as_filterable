ActsAsFilterable.configure do |config|

  config.add_filter :default_zero do |value|
    value || 0
  end

  config.add_filter :default_price do |value|
    value || 0.0
  end

  config.add_filter :integer_cast do |value|
    value.try(:to_i)
  end

  config.add_filter :titleization do |value|
    value.try(:titleize)
  end

end
