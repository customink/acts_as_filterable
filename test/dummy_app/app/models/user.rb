class User < ActiveRecord::Base
  acts_as_filterable :digits,    :phone_number
  acts_as_filterable :lowercase, :handle
end
