module ActsAsFilterable
  class Railtie < ::Rails::Railtie
    
    config.acts_as_filterable = ActsAsFilterable.config

    initializer 'acts_as_filterable.after.load_active_support', :after => :load_active_support, :group => :all do |app|
      ActiveSupport.on_load(:active_record) { require 'acts_as_filterable/base' }
    end
    
  end
end
