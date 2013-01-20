require 'active_record'
require 'acts_as_filterable/base'

module ActsAsFilterable
end

ActiveRecord::Base.send :include, ActsAsFilterable::ActiveRecordExt::Base
