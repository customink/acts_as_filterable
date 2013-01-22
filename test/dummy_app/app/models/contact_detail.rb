class ContactDetail < ActiveRecord::Base
  acts_as_filterable :digits, :phone_number, :fax_number
end
