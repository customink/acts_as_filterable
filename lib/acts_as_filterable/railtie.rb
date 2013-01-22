module ActsAsFilterable
  class Railtie < ::Rails::Railtie
    
    config.acts_as_filterable = ActsAsFilterable.config

    config.after_initialize do |app|
      require 'acts_as_filterable/base'
    end
    
  end
end
